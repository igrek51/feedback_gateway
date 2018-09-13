from django.contrib import admin

from .models import ContactMessage


# Register your models here.


class ContactMessageAdmin(admin.ModelAdmin):
    fieldsets = [
        (None, {'fields': ['id', 'datetime', 'message', 'author', 'application_id']}),
    ]
    list_display = ('id', 'datetime', 'message', 'author', 'application_id')
    list_filter = ['id', 'datetime', 'message', 'author', 'application_id']
    search_fields = ['id', 'datetime', 'message', 'author', 'application_id']


admin.site.register(ContactMessage, ContactMessageAdmin)
