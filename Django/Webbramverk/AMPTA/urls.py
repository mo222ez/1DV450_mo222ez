from django.conf.urls import patterns, include, url
from django.contrib.auth.models import User, Group
from django.views.generic import DetailView, ListView
from AMPTA.models import Project, Ticket, Status

from AMPTA import views

urlpatterns = patterns("", 
	url(r'^$', views.index, name = "index"),
	url(r'^login', views.login_user, name = "login"),
	url(r'^logout$', views.logout_user, name = "logout"),
	# project
	url(r'^projects/$', views.projects, name = "projects" ),
	url(r'^projects/(?P<project_id>\d+)$', views.show_project, name = "show_project" ),
	url(r'^projects/(?P<project_id>\d+)/edit$', views.edit_project, name = "edit_project" ),
	url(r'^projects/new$', views.new_project, name = "new_project" ),
	url(r'^projects/create$', views.create_project, name = "create_project" ),
	url(r'^projects/(?P<project_id>\d+)/delete$', views.delete_project, name = "delete_project" ),
	# ticket
	url(r'^projects/(?P<project_id>\d+)/tickets/(?P<ticket_id>\d+)$', views.show_ticket, name = "show_ticket" ),
	url(r'^projects/(?P<project_id>\d+)/tickets/(?P<ticket_id>\d+)/edit$', views.edit_ticket, name = "edit_ticket" ),
	url(r'^projects/(?P<project_id>\d+)/tickets/new$', views.new_ticket, name = "new_ticket" ),
	url(r'^projects/(?P<project_id>\d+)/tickets/create$', views.create_ticket, name = "create_ticket" ),
	url(r'^projects/(?P<project_id>\d+)/tickets/(?P<ticket_id>\d+)/delete$', views.delete_ticket, name = "delete_ticket" ),
	# user
	url(r'^users/$', views.users, name = "users" ),
	url(r'^users/(?P<user_id>\d+)$', views.show_user, name = "show_user" ),
)