class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :current_user

private
	def current_user
		@user ||= User.find(session[:user_id]) if session[:user_id]
	end
	helper_method :current_user

	def auth
		if current_user == nil
			redirect_to root_url
		end
	end
end
