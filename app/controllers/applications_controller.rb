class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    desired_pets = PetApplication.where('application_id = ?', @application.id)
    @pet_apps = desired_pets.map do |pet_application|
      Pet.find(pet_application.pet_id)
    end.uniq
  end
end
