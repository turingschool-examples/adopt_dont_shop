class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @app_pet = @application.application_pets
    # require "pry"; binding.pry
  end

  def update
    i = 0
    @application = Application.find(params[:id])
    @app_pet = ApplicationPet.find(params[:app_id])
    @application.application_pets.each do |app_pet|
      if params[:status] == "Approve"
        app_pet.pet_status = 'Approved'
        @app_pet.pet_status = 'Approved'
      elsif params[:status] == 'Reject'
        app_pet.pet_status = 'Rejected'
        @app_pet.pet_status = 'Rejected'
        @application.status = 'Rejected'
      end
    end
    @application.application_pets.each do |app|
      if app.pet_status == 'Approved'
        i += 1
      end
    end
    if @application.application_pets.count == i
      @application.status = 'Approved'
    end
    @application.save
    @app_pet.save
    redirect_to "/admin/applications/#{@application.id}"
  end
end
