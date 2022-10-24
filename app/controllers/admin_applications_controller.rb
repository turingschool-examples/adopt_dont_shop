class AdminApplicationsController < ApplicationController
  def show
    require 'pry'; binding.pry
    @application = Application.find(params[:id])
    app_pets = ApplicationPet.where(application_id: @application.id)
    @pets = app_pets.flat_map do |app|
      Pet.where(id: app.pet_id)
    end
  end

end