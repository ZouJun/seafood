class Admin::HomeController < Admin::BaseController
	skip_before_filter :page_can?
	def index
	
	end
end