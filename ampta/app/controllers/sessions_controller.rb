#!/bin/env ruby
# encoding: utf-8
class SessionsController < ApplicationController
  def new
    if session[:user_id]
      redirect_to start_path
    end
  end

  def create
  	user = User.find_by_email(params[:email])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect_to start_path, :notice => "Inloggad"
  	else
  		flash.now[:error] = "Fel email eller lösenord"
  		render "new"
  	end
  end

  def destroy
  	session[:user_id] = nil
    flash[:success] = "Utloggad"
  	redirect_to root_url, :success => "Utloggad" 
  end
end
