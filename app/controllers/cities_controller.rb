class CitiesController < ApplicationController

	##省市联动查询
	def index
		if params[:province_id].present?
			@cities = City.where(province_id: params[:province_id])
		else
			@cities =[]
		end

		respond_to do |format|
      		format.json { render json: @cities }
    	end
	end
end