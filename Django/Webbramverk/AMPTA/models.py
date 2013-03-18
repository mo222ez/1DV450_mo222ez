# -*- coding: utf-8 -*-

from django.db import models
from django.contrib.auth.models import User, Group
from django.utils import timezone
import datetime
from django.forms import ModelForm
from django import forms

# Create your models here.
class Project(models.Model):
	"""docstring for Project"""
	# project_members = models.ManyToManyField(User, through = "ProjectMember")
	members = models.ManyToManyField(User, related_name = "projects")
	name = models.CharField(max_length = 50, blank = False)
	description = models.TextField(blank = False)
	start_date = models.DateTimeField("Startdatum för projektet")
	end_date = models.DateTimeField("Slutdatum för projektet")
	owner = models.ForeignKey(User, related_name = "owner")
	def __unicode__(self):
		return self.name
	def is_member(self, user):
		return self.members.filter(pk = user.id)

# class ProjectMember(models.Model):
# 	"""docstring for ProjectMember"""
# 	user = models.ForeignKey(User)
# 	project = models.ForeignKey(Project)

class Status(models.Model):
	"""docstring for Status"""
	status_name = models.CharField(max_length = 50, blank = False)
	def __unicode__(self):
		return self.status_name

class Ticket(models.Model):
	"""docstring for Ticket"""
	name = models.CharField(max_length = 50, blank = False)
	description = models.TextField(blank = False)
	project = models.ForeignKey(Project)
	status = models.ForeignKey(Status)
	owner = models.ForeignKey(User, related_name = "tickets")
	def __unicode__(self):
		return self.name

class LoginForm(forms.Form):
	"""docstring for LoginForm"""
	username = forms.CharField(max_length = 30)
	password = forms.CharField(max_length = 30, widget = forms.PasswordInput)

class TicketForm(ModelForm):
	"""docstring for ClassName"""
	class Meta:
		model = Ticket
		exclude = ("project"), ("owner")

class ProjectForm(ModelForm):
	start_date = forms.DateField(initial = timezone.now())
	end_date = forms.DateField(initial = timezone.now() + datetime.timedelta(days = 5))
	"""docstring for ProjectForm"""
	class Meta:
		model = Project
		exclude = ("owner")
		














		