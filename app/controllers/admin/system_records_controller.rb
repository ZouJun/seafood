class Admin::SystemRecordsController < Admin::BaseController

	def index
		@search = SystemRecord.search(params[:search])
    	@system_records = @search.order("created_at desc").page(params[:page])
	end
end