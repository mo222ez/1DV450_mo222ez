# -*- coding: utf-8 -*-

# Create your views here.
from django.shortcuts import get_list_or_404, get_object_or_404, render, redirect
from django.contrib.auth import authenticate, login, logout
from django.contrib.auth.models import User, Group

from django.contrib.auth.decorators import login_required, permission_required

from django import template
from django.http import HttpResponse
from django.template import Context, loader
from django.forms import forms

from django.core.urlresolvers import reverse

from AMPTA.models import Project, Ticket, Status, LoginForm, TicketForm, ProjectForm

@login_required
def index(request):
	# projects = Project.objects
	return render(request, "index.html")

def login_user(request):
	if request.user.is_authenticated():
		return redirect("AMPTA:index")
	message = ""

	if request.method == "POST":
		form = LoginForm(request.POST)
		if form.is_valid():
			username_to_try = form.cleaned_data["username"]
			password_to_try = form.cleaned_data["password"]

			user = authenticate(username = username_to_try, password = password_to_try)
			if user is not None:
				if user.is_active:
					login(request, user)
					request.session["has_logged_in"] = True
					return redirect("AMPTA:index")
				else:
					return HttpResponse("<h1>Konto inaktiverat</h1>")	
			else:
				message = "<h1>Fel login</h1>"
	else:
		form = LoginForm()
	return render(request, "login/index.html", { "form": form, "message": message })

@login_required
def logout_user(request):
	logout(request)
	return redirect("AMPTA:login")

@login_required
def projects(request):
	projects = get_list_or_404(Project)
	context = { "projects": projects }
	return render(request, "projects/index.html", context)

@login_required
def show_project(request, project_id):
	project = get_object_or_404(Project, pk = project_id)
	tickets = Ticket.objects.filter(project = project)
	context = { "project": project, "tickets": tickets }
	return render(request, "projects/show.html", context)

@login_required
def edit_project(request, project_id):
	project = get_object_or_404(Project, pk = project_id)
	if request.user.id is not project.owner.id:
		return redirect("AMPTA:show_project", str(project_id))
	if request.method == "POST":
		form = ProjectForm(request.POST, instance = project)
		if form.is_valid():
			project = form.save(commit = False)
			if request.user not in project.members.all():
				project.members.add(request.user)
			project.save()
			context = { "project": project }
			return redirect("AMPTA:show_project", str(project_id))
		else:
			message = "Felaktig formulärdata"
			return render(request, "projects/edit.html", { "project": project, "form": form, "message": message })
	if project is not None:
		form = ProjectForm(instance = project)
		context = { "project": project, "form": form }
		return render(request, "projects/edit.html", context)
	else:
		return render(request, "index.html")

@login_required
def new_project(request):
	form = ProjectForm()
	context = { "form": form }
	return render(request, "projects/new.html", context)

@login_required
def create_project(request):
	if request.method == "POST":
		form = ProjectForm(request.POST)
		if form.is_valid():
			form.instance.owner = request.user
			project = form.save();
			context = { "project_id": project.id }
			return redirect("AMPTA:show_project", str(project.id))
		else:
			message = "Felaktig formulärdata"
			return render(request, "projects/new.html", { "form": form, "message": message })
	else:
		return redirect("AMPTA:new_project")

@login_required
def delete_project(request, project_id):
	project = get_object_or_404(Project, pk = project_id)
	if project is not None:
		if request.user.id == project.owner.id:
			project.delete();
		else:
			pass
	return redirect("AMPTA:index")

@login_required
def show_ticket(request, project_id, ticket_id):
	ticket = get_object_or_404(Ticket, pk = ticket_id)
	context = { "ticket": ticket }
	return render(request, "tickets/show.html", context)

@login_required
def edit_ticket(request, project_id, ticket_id):
	ticket = get_object_or_404(Ticket, pk = ticket_id)
	project = get_object_or_404(Project, pk = project_id)
	if request.user.id is not project.owner.id:
		if request.user.id is not ticket.owner.id:
			return redirect("AMPTA:show_ticket", str(project_id), str(ticket_id))

	if request.method == "POST":
		form = TicketForm(request.POST, instance = ticket)
		if form.is_valid():
			ticket = form.save()
			context = { "project_id": project_id, "ticket": ticket }
			return redirect("AMPTA:show_ticket", str(project_id), str(ticket_id))
		else:
			message = "Felaktig formulärdata"
			return render(request, "tickets/edit.html", { "project": project, "ticket": ticket , "form": form, "message": message })
	if ticket is not None and project is not None:
		form = TicketForm(instance = ticket)
		context = { "project": project, "ticket": ticket, "form": form }
		return render(request, "tickets/edit.html", context)
	elif project is not None:
		return render(request, "project/show.html", { "project": project })
	else:
		return render(request, "index.html")

@login_required
def new_ticket(request, project_id):
	project = get_object_or_404(Project, pk = project_id)

	if request.user in project.members.all():
		form = TicketForm()
		context = { "project": project, "form": form }
		return render(request, "tickets/new.html", context)
	else:
		return redirect("AMPTA:show_project", str(project_id))

@login_required
def create_ticket(request, project_id):
	project = get_object_or_404(Project, pk = project_id)
	if request.user not in project.members.all():
		return redirect("AMPTA:show_project", str(project_id))
	if request.method == "POST":
		form = TicketForm(request.POST)
		if form.is_valid():
			form.instance.owner = request.user
			form.instance.project = project
			ticket = form.save();
			context = { "project_id": project.id, "ticket": ticket }
			return redirect("AMPTA:show_ticket", str(project_id), str(ticket.id))
		else:
			message = "Felaktig formulärdata"
			return render(request, "tickets/new.html", { "project": project, "form": form, "message": message })
	else:
		form = TicketForm()
		context = { "project": project, "form": form }
		return render(request, "tickets/new.html", context)

@login_required
def delete_ticket(request, project_id, ticket_id):
	project = get_object_or_404(Project, pk = project_id)
	ticket = get_object_or_404(Ticket, pk = ticket_id)
	if request.user.id is not project.owner.id:
		if request.user.id is not ticket.owner.id:
			return redirect("AMPTA:show_ticket", str(project_id), str(ticket_id))

	if project is not None:
		if ticket is not None:
			if request.user.id == ticket.owner.id:
				ticket.delete();
			elif request.user.id == project.owner.id:
				ticket.delete();
			else:
				pass
	return redirect("AMPTA:show_project", str(project_id))

@login_required
def users(request):
	inspect_users = User.objects.all();
	context = { "inspect_users": inspect_users }
	return render(request, "user/index.html", context)

@login_required
def show_user(request, user_id):
	inspect_user = User.objects.get(pk = user_id)
	context = { "inspect_user": inspect_user }
	return render(request, "user/show.html", context)














