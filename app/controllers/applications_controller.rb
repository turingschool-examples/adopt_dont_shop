class ApplicationsController < ApplicationController
	def show
		@application = Application.find(params[:id])
	end

	def new
	end

	def create
		# application = Application.create(application_params)
		application = Application.new(application_params)
		if application.save
			redirect_to "/applications/#{application.id}"
		else
			redirect_to "/applications/new", alert: "Error: Please fill out all required fields!"
		end
	end

private
	def application_params
		params.permit(:name, :street_address, :city, :state, :zip_code, :description)
	end
end
