class ProjectsController < ApplicationController
	before_filter :auth
	def index
		@projects = Project.all
	end

	def show
		@project = Project.find(params[:id])
		session[:session_project_id] = @project.id
	end

	def new
		if session[:failed_project] != nil && session[:failed_validation] != nil
			session[:failed_validation] = nil
			@project = session[:failed_project]
		else
			@project = Project.new
		end
		@users = User.all
	end

	# POST /projects
	def create
		@project = Project.new(params[:project])
		@project.owner_id = @user.id
		if @project.save
			respond_to do |format|
				unless params[:project_users] == nil
					updateProjectUsers
				end
				@project.users << @user
				session[:failed_project] = nil
				format.html { redirect_to @project, notice: "Projektet skapades" }
			end
			# redirect_to @project, :notice "Projektet skapades"
			# redirect_to action :show, :notice "Projektet skapades"
		else
			# render :action => "new"
			session[:failed_project] = @project
			session[:failed_validation] = "failed_validation"
			redirect_to projects_new_path
		end
	end

	def edit
		@project = Project.find(params[:id])
		if @user.id != @project.owner_id
			redirect_to project_path
		end
		if session[:failed_validation_update_errors] != nil
			@session_errors = session[:failed_validation_update_errors]
			session[:failed_validation_update_errors] = nil
		end

		@users = User.all
	end

	def update
		@project = Project.find(params[:id])
		# puts @project
		@project.users.delete(@project.users)
		@project.owner_id = @user.id

		if @project.update_attributes(params[:project])
			unless params[:project_users] == nil
				updateProjectUsers
			end
			@project.users << @user
			session[:failed_project] = nil
			redirect_to @project, notice: "Projektet uppdaterades"
		else
			#session[:failed_project_update] = @project
			#session[:failed_validation_update] = "failed_validation_update"
			session[:failed_validation_update_errors] = @project.errors.full_messages
			@project.users << @user
			redirect_to edit_project_path
		end
	end

	def updateProjectUsers
		@project.users.delete(@project.users)
		params[:project_users].each do |u|
			user = User.find(u)
			unless @project.users.include?(user)
				@project.users << user
			end
		end
	end

	def destroy
		@project = Project.find(params[:id])
		@project.destroy
		redirect_to projects_path
	end
end
