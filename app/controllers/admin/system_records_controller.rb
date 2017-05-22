class Admin::SystemRecordsController < Admin::BaseController

	##系统日志列表
	def index
		@search = SystemRecord.search(params[:search])
    @system_records = @search.order("created_at desc").page(params[:page])
	end
end