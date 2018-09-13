from django.http import HttpResponse
from django.shortcuts import render
from django.utils import timezone
# Create your views here.
from django.views.decorators.csrf import csrf_exempt

from contact.models import ContactMessage


def send_message_form(request):
    return render(request, 'contact/send.html')


@csrf_exempt
def send_message(request):
    message = request.POST.get('message')
    author = request.POST.get('author')

    application_id = request.POST.get('application_id')
    if not author:
        author = None

    if not message:
        return HttpResponse(
            "400 - No message given. - " + str(request.body) + ' - ' + str(request.method) + ' - ' + str(
                request.content_type) + "; " + str(request.content_params))

    # creating message
    cm = ContactMessage(message=message, author=author, datetime=timezone.now(), application_id=application_id)
    # Save the object into the database
    cm.save()

    return HttpResponse("200 - Message has been sent.")
