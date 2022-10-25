class AdminApplicationsController < ApplicationsController
  def show 
    @application = Application.find(params[:id])
    view_with_decision
  end

  def application_pets_pending
    pending = []
    @application.pets.each do |pet|
      pet.pet_applications.each do |application|
        if application.rejected == false && application.approved == false && application.application_id == @application.id
          pending << pet
        end
      end
    end
    pending
  end

  def application_pets_approved
    approved = []
    @application.pets.each do |pet|
      pet.pet_applications.each do |application|
        if application.approved == true && application.application_id == @application.id
          approved << pet
        end
      end
    end
    approved
  end

  def application_pets_rejected
    rejected = []
    @application.pets.each do |pet|
      pet.pet_applications.each do |application|
        if application.rejected == true && application.application_id == @application.id
          rejected << pet
        end
      end
    end
    rejected
  end

  def application_decision(parameter)
    pet = Pet.find(params[:pet_id])
    pet.pet_applications.each do |application|
      if application.application_id == @application.id && application.pet_id == pet.id
        application.update(parameter => params[parameter])
        application.save
      end
    end
    redirect_to "/admin/applications/#{@application.id}"
  end

  def pet_lists
    @pets_pending = application_pets_pending
    @pets_approved = application_pets_approved
    @pets_rejected = application_pets_rejected
  end


  def view_with_decision
    if params[:approved].present?
      application_decision(:approved)
    elsif params[:rejected].present?
      application_decision(:rejected)
    else
      pet_lists
    end
  end
end