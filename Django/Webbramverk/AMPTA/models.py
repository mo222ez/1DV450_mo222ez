# -*- coding: utf-8 -*-

from django.db import models
from django.contrib.auth.models import User, Group
from django.core.exceptions import ValidationError
from django.utils import timezone
import datetime
from django.forms import ModelForm, Widget
from django import forms

# Create your models here.
class Project(models.Model):
	"""docstring for Project"""
	# project_members = models.ManyToManyField(User, through = "ProjectMember")
	members = models.ManyToManyField(User, related_name = "projects", error_messages = { "required": "hello" })
	name = models.CharField(max_length = 50, blank = False)
	description = models.TextField(blank = False)
	start_date = models.DateTimeField("Startdatum för projektet")
	end_date = models.DateTimeField("Slutdatum för projektet")
	owner = models.ForeignKey(User, related_name = "owner")
	def __unicode__(self):
		return self.name
	def is_member(self, user):
		return self.members.filter(pk = user.id)
	def valid_deadline(self):
		return self.start_date < self.end_date
	# def clean(self):
	# 	super(Project, self).clean(*args, **kwargs)
	# 	if self.start_date > self.end_date:
	# 		raise ValidationError("Datum för deadline måste ligga efter startdatum")

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
	# members = forms.ModelMultipleChoiceField(queryset = ))
	name = forms.CharField(widget = forms.TextInput(attrs = { "class": "input-xlarge" }))
	description = forms.CharField(widget = forms.Textarea(attrs = { "class": "input-xlarge" }))
	start_date = forms.DateField(initial = timezone.now(), widget = forms.DateInput(attrs = { "class": "span12", "readonly": "" }))
	end_date = forms.DateField(initial = timezone.now() + datetime.timedelta(days = 5), widget = forms.DateInput(attrs = { "class": "span12", "readonly": "" }))
	"""docstring for ProjectForm"""
	class Meta:
		model = Project
		exclude = ("owner")
	def clean(self):
		cleaned_data = super(ProjectForm, self).clean()
		start_date = cleaned_data["start_date"]
		end_date = cleaned_data["end_date"]
		if start_date > end_date:
			raise forms.ValidationError("Datum för deadline måste ligga efter startdatum")
		return cleaned_data
		














		