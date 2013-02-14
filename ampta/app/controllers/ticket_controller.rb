class TicketController < ApplicationController
  before_filter :auth
  def index
  end

  def edit
  	@ticket = Ticket.find(params[:id])
    @project = @ticket.project
    if @user.id != @ticket.user_id && @user.id != @ticket.project.owner_id
      redirect_to project_path(@project)
    end
  	if session[:failed_ticket_validation_update_errors] != nil
  		@session_update_errors = session[:failed_ticket_validation_update_errors]
  		session[:failed_ticket_validation_update_errors] = nil
  	end
  end

  def update
  	@ticket = Ticket.find(params[:id])
    @project = @ticket.project

  	if @ticket.update_attributes(params[:ticket])
  		redirect_to project_path(session[:session_project_id]) + ticket_path(@ticket)
  	else
  		session[:failed_ticket_validation_update_errors] = @ticket.errors.full_messages
  		redirect_to project_path(session[:session_project_id]) + edit_ticket_path
  	end
  end

  def new
    if @user.projects.include?(session[:session_project_id])
      # redirect_to project_path
    end
  	if session[:failed_ticket] != nil && session[:failed_ticket_validation] != nil
  		session[:failed_ticket_validation] != nil
  		@ticket = session[:failed_ticket]
  	else 
  		@ticket = Ticket.new
  	end
  end

  def create
  	@ticket = Ticket.new(params[:ticket])
  	@ticket.user_id = @user.id
  	@ticket.project_id = session[:session_project_id]
    
  	if @ticket.save
  		#redirect_to Project.find(session[:session_project_id])
  		session[:failed_ticket] = nil
  		redirect_to project_path(session[:session_project_id])
  	else
  		session[:failed_ticket] = @ticket
  		session[:failed_ticket_validation] = "failed_ticket_validation"
  		render :action => "new"
  	end
  end

  def show
  	@ticket = Ticket.find(params[:id])
    @project = @ticket.project
  end

  def destroy
    if @user.id != @ticket.user_id && @user.id != @ticket.project.owner_id
      redirect_to project_path(@project)
    end
  	@ticket = Ticket.find(params[:id])
  	@ticket.destroy
  	redirect_to project_path(session[:session_project_id])
  end
end
