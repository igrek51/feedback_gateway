from django.test import TestCase
from django.urls import reverse

from .models import ContactMessage


class ContactMessageTests(TestCase):

    def test_creating_new_message(self):
        """
        creates new message in database
        """
        assert ContactMessage.objects.count() == 0

        url = reverse('contact:send_message')
        response = self.client.post(url, {
            'message': 'dupa',
            'author': 'igrek'
        })

        assert ContactMessage.objects.count() == 1
        assert ContactMessage.objects.get(message='dupa').author == 'igrek'
        self.assertEquals(response.status_code, 200)
        assert '200 - Message has been sent.' in str(response.content)

    def test_creating_anonymous_message(self):
        """
        creates new message in database without author
        """
        url = reverse('contact:send_message')
        response = self.client.post(url, {
            'message': 'dupa',
            'author': ''
        })
        self.assertEquals(response.status_code, 200)
        assert '200 - Message has been sent.' in str(response.content)
        assert ContactMessage.objects.get(message='dupa').author is None

        response = self.client.post(url, {
            'message': 'dupa2'
        })
        self.assertEquals(response.status_code, 200)
        assert '200 - Message has been sent.' in str(response.content)
        assert ContactMessage.objects.get(message='dupa2').author is None

    def test_creating_message_without_content(self):
        """
        returns error when trying to send empty message
        """
        url = reverse('contact:send_message')
        response = self.client.post(url)
        assert '400 - No message given.' in str(response.content)

        response = self.client.post(url, {
            'message': '',
            'author': ''
        })
        assert '400 - No message given.' in str(response.content)


class SendMessageFormViewTests(TestCase):

    def test_open_form_view_page(self):
        response = self.client.get(reverse('contact:send_message_form'))
        assert response.status_code == 200
