class SessionsController < ApplicationController
	def create
		#render :text => request.env['rack.auth'].inspect
		#@andrewID = 
		#unless @auth = User.find_by_andrew_id(@andrew_id)
		#	@auth = User.create
		#	@auth = 
		#end
		#self.current_user = @auth.user
		
		#render :text => "Welcome, #{current_user.name}."
		
		if Rails.env == "production"
			auth = request.env["omniauth.auth"]
			#user = User.find_by_andrew_id(auth["uid"])
		else
			user = User.find_by_andrew_id('admin')
		end


		reset_session
		session[:user_id] = user.id
		flash[:notice] = "You have been successfully logged in"
		#puts "You have been logged in as #{auth["uid"]}"
		puts "You have been logged in as #{current_user.andrew_id}"
		redirect_to request.env['omniauth.origin'] || root_url
	end
	
	def destroy
    @current_user = nil
    reset_session

    flash[:notice] = "You have been logged out"
    redirect_to root_url(:subdomain => false)
  end
end