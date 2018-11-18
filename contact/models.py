from django.db import models


# Create your models here.


class ContactMessage(models.Model):
    message = models.TextField()
    subject = models.TextField(blank=True, null=True)
    author = models.TextField(blank=True, null=True)
    datetime = models.DateTimeField()
    application_id = models.IntegerField(default=1, null=True)
    ip_address = models.TextField(blank=True, null=True)

    def __str__(self):
        return self.message

    def has_author(self):
        return self.author is not None
