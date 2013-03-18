from django.contrib import admin
from AMPTA.models import Project, Ticket, Status

admin.site.register(Project)
admin.site.register(Ticket)
admin.site.register(Status)