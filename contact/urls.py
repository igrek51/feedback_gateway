from django.urls import path

from . import views

app_name = 'contact'
urlpatterns = [
    path('', views.send_message_form, name='send_message_form'),
    path('send/', views.send_message, name='send_message'),
]