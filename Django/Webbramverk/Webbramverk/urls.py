from django.conf.urls import patterns, include, url

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
# from AMPTA.models import Project, Ticket, Status
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'Webbramverk.views.home', name='home'),
    # url(r'^Webbramverk/', include('Webbramverk.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^ampta/admin/', include(admin.site.urls)),
    url(r'^ampta/', include("AMPTA.urls", namespace = "AMPTA")),
)
