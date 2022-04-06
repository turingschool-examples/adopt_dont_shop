class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @app_pet = @application.application_pets
    # require "pry"; binding.pry
  end

  def update
    @app_pet = ApplicationPet.find(params[:app_id])
    
    if params[:status] == "Approve"
      @app_pet.pet_status = 'Approved'
    elsif params[:status] == 'Reject'
      @app_pet.pet_status = 'Rejected'
      @app_pet.application.status = 'Rejected'
    end
    
    @app_pet.save
    
    i = 0
    all_app_pets = ApplicationPet.all
    all_app_pets.each do |app|
      if app.pet_status == "Approved"
        i += 1
      end
    end
    
    if all_app_pets.count == i
      @app_pet.application.status = 'Approved'  
    end
    
    @app_pet.application.save
    redirect_to "/admin/applications/#{@app_pet.application.id}"
  end
end
