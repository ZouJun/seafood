class DistrictsController < ApplicationController 

	##市区联动查询
	def index
		if params[:city_id].present?
			@districts = District.where(city_id: params[:city_id])
		else
			@districts =[]
		end

		respond_to do |format|
      		format.json { render json: @districts }
    	end
	end
end