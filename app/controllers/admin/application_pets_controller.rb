class Admin::ApplicationPetsController < ApplicationController

	def update
		application_pet = ApplicationPet.where(application_id: params[:application_id], pet_id: params[:pet_id]).first
		application_pet.status = params[:status]
		application_pet.save

		redirect_to "/admin/applications/#{params[:application_id]}"
	end


end 