class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pet_id_pairs = @application.pets.pluck(:id, :name)
  end
  
  def update
    application_pet = ApplicationPet.find_by(pet_id: params[:adopt], application_id: params[:id])
    application_pet.update(adopted: true)
  end
end
