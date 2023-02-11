class ApplicationsController < ApplicationController
	def show
		@application = Application.find(params[:id])
		@pets = @application.pets
		if !params[:pet_name].nil?
			@pet_search = Pet.search(params[:pet_name])
		else
			@pet_search = []
		end
  end

	def new

	end

	def create
		application = Application.new(app_params)
    if application.save
		  redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Required Information Missing"
    end
	end

	def update
		application = Application.find(params[:id])
		PetApplication.create!(application_id: application.id, pet_id: params[:pets])
		# application.update(update_params)
		
		redirect_to "/applications/#{application.id}"
	end

	private
	
	def app_params
		params.permit(:name, :street, :city, :state, :zip, :desc, :status)
	end

	def update_params
		params.permit(:pets)
	end
end