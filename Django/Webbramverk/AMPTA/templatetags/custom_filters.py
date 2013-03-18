from django import template
register = template.Library()

@register.filter(name = 'ownership')
def ownership(ticket, user):
	return ticket.owner_id == user