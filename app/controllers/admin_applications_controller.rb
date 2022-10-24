class AdminApplicationsController < ApplicationsController
  def show 
    @application = Application.find(params[:id])
    view_with_approval
  end

  def application_pets_not_approved
    not_approved = []
    @application.pets.each do |pet|
      pet.pet_applications.each do |application|
        if application.approved == false && application.application_id == @application.id
          not_approved << pet
        end
      end
    end
    not_approved
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

  def application_submission_show_up
    @display = false
    if @application.pets.length > 0
      @display = true
    end
  end

  def application_approval
    pet = Pet.find(params[:pet_id])
    pet.pet_applications.each do |application|
      if application.application_id == @application.id && application.pet_id == pet.id
        application.update(:approved => params[:approved])
        application.save
      end
    end
  end


  def view_with_approval
    if params[:approved].present?
      application_approval
      redirect_to "/admin/applications/#{@application.id}"
    else
      @pets_not_approved = application_pets_not_approved
      @pets_approved = application_pets_approved
    end
  end
end