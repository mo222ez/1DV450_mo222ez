class HomeController < ApplicationController
  def index
  	if session[:user_id]
  		@user = User.find(session[:user_id])
  	else
  		redirect_to root_url
  	end
  end
end
