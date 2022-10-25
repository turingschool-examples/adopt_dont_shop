class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    app_pets = ApplicationPet.where(application_id: @application.id)
    @pets = app_pets.flat_map do |app|
      Pet.where(id: app.pet_id)
    end
  end

  def update
    application = Application.find(params[:id])
    app_pet = ApplicationPet.where("application_id = #{application.id} AND pet_id = #{params[:pet]}")
    app_pet.update(status: params[:status])
    redirect_to "/admin/applications/#{application.id}"
  end

end