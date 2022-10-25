class AdminApplicationsController < ApplicationsController
  def show 
    @application = Application.find(params[:id])
    view_with_decision
  end

  def pending_pet_applications
    @application.pets.map do |pet|
      pet.pet_applications.pets_based_on_application(false, false, @application.id)
    end
  end

  def approved_pet_applications
    @application.pets.map do |pet|
      pet.pet_applications.pets_based_on_application(false, true, @application.id)
    end
  end

  def rejected_pet_applications
    @application.pets.map do |pet|
      pet.pet_applications.pets_based_on_application(true, false, @application.id)
    end
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

  def pet_application_lists
    @pet_applications_pending = pending_pet_applications3.flatten
    @pet_applications_approved = approved_pet_applications.flatten
    @pet_applications_rejected = rejected_pet_applications.flatten
  end


  def view_with_decision
    if params[:approved].present?
      application_decision(:approved)
    elsif params[:rejected].present?
      application_decision(:rejected)
    else
      pet_application_lists
    end
  end
end