class TicketController < ApplicationController
  def index
  end

  def edit
  	@ticket = Ticket.find(params[:id])
  end

  def update
  	@ticket = Ticket.find(params[:id])

  	if @ticket.update_attributes(params[:ticket])
  		# redirect_to session[:session_project_id] + ticket_path(@ticket)
  		redirect_to project_path(session[:session_project_id]) + ticket_path(@ticket)
  	else
  		redirect_to edit_ticket_path
  	end
  end

  def new
  	@ticket = Ticket.new
  end

  def create
  	@ticket = Ticket.new(params[:ticket])
  	@ticket.user_id = @user.id
  	@ticket.project_id = session[:session_project_id]

  	if @ticket.save
  		#redirect_to Project.find(session[:session_project_id])
  		redirect_to project_path(session[:session_project_id])
  	else
  		render :action => "new"
  	end
  end

  def show
  	@ticket = Ticket.find(params[:id])
  end

  def destroy
  	@ticket = Ticket.find(params[:id])
  	@ticket.destroy
  	redirect_to project_path(session[:session_project_id])
  end
end
