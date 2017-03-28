class HomeController < ApplicationController

	def index
		if session[:staff_id]
			redirect_to admin_home_path
		else
			redirect_to sign_in_path
		end
	end
end