class Admin::SystemRecordsController < Admin::BaseController

	def index
		@search = SystemRecord.search(params[:search])
    	@system_records = @search.page(params[:page])
	end
end