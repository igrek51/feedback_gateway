import smtplib

from django.http import HttpResponse
from django.utils import timezone
from django.views.decorators.csrf import csrf_exempt

from contact.models import ContactMessage


# Create your views here.


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

    server = smtplib.SMTP('vps544895.ovh.net', 25)
    server.set_debuglevel(1)
    from_address = 'songbook@vps544895.ovh.net'
    to_address = 'igrek.s@o2.pl'
    subject = 'SongBook Feedback'
    text = 'Here is the message from %s:\n%s' % (author, message)
    message = """To: {}\nFrom: {}\nSubject: {}\n\n{}""".format(to_address, from_address, subject, text)
    server.sendmail(from_address, to_address, message)
    server.quit()

    return HttpResponse("200 - Message has been sent.")
