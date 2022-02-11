class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    pet_ids = @application.pet_names.split
    @pets = Pet.where(id: pet_ids)
  end
end
