from django.shortcuts import render


# Create your views here.


def send_message_form(request):
    return render(request, 'contact/send.html')
