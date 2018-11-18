from django.contrib import admin

from .models import ContactMessage


# Register your models here.


class ContactMessageAdmin(admin.ModelAdmin):
    fieldsets = [
        (None, {'fields': ['datetime', 'subject', 'message', 'author', 'ip_address', 'application_id']}),
    ]
    list_display = ('datetime', 'subject', 'message', 'author', 'application_id', 'ip_address', 'id')
    list_filter = ['subject', 'datetime', 'author', 'application_id']
    search_fields = ['id', 'datetime', 'subject', 'message', 'author', 'application_id']


admin.site.register(ContactMessage, ContactMessageAdmin)
