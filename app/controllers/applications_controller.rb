class ApplicationsController < ApplicationController
	def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

	def new

	end

	def create
		application = Application.create!(app_params)
		redirect_to "/applications/#{application.id}"
	end

	private
	
	def app_params
		params.permit(:name, :street, :city, :state, :zip, :desc, :status)
	end
end