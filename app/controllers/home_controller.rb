class HomeController < ApplicationController
	skip_before_filter :page_can?
	def index
		if session[:staff_id]
			redirect_to admin_home_path
		else
			redirect_to sign_in_path
		end
	end
end