class AdminApplicationsController < ApplicationsController
  def show 
    @application = Application.find(params[:id])
    view_with_decision
  end

  def pending_pet_applications
    @application.pets.map do |pet|
      pet.pet_applications.based_on_conditions(false, false, @application.id)
    end
  end

  def approved_pet_applications
    @application.pets.map do |pet|
      pet.pet_applications.based_on_conditions(false, true, @application.id)
    end
  end

  def rejected_pet_applications
    @application.pets.map do |pet|
      pet.pet_applications.based_on_conditions(true, false, @application.id)
    end
  end

  def application_decision(parameter)
    applications = Pet.find(params[:pet_id]).pet_applications.based_on_ids(params[:pet_id], @application.id)
    applications.each do |application|
      application.update(parameter => params[parameter])
      application.save
    end
    redirect_to "/admin/applications/#{@application.id}"
  end

  def pet_application_lists
    @pet_applications_pending = pending_pet_applications.flatten
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