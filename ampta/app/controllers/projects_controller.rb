class ProjectsController < ApplicationController
	before_filter :auth
	def index
		@projects = Project.all
	end

	def show
		@project = Project.find(params[:id])
	end

	def new
		@project = Project.new
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
				format.html { redirect_to @project, notice: "Projektet skapades" }
			end
			# redirect_to @project, :notice "Projektet skapades"
			# redirect_to action :show, :notice "Projektet skapades"
		else
			# render :action => "new"
			redirect_to projects_new_path
		end
	end

	def edit
		@project = Project.find(params[:id])
		@users = User.all
	end

	def update
		@project = Project.find(params[:id])
		puts @project
		@project.owner_id = @user.id
		if @project.update_attributes(params[:project])
			unless params[:project_users] == nil
				updateProjectUsers
			end
			@project.users << @user

			redirect_to @project, notice: "Projektet skapades"
		else
			render "new"
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
