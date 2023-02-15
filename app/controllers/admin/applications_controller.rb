class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])
    @petapplication = PetApplication.find(params[:pet_application_id])
    @petapplication.update(application_id: params[:id], pet_id: params[:petid], status: params[:status])

    approve_or_reject_application unless status_array.include?('Pending')
    redirect_to "/admin/applications/#{params[:id]}"
  end

  private

  def status_array
    @application.pets.map do |pet|
      @application.pet_application_by_pet(pet).status
    end
  end

  def approve_application
    @application.update(status: 'Approved')
    @application.pets.each do |pet|
      pet.update(adoptable: false)
    end
  end

  def approve_or_reject_application
    if status_array.include?('Rejected')
      @application.update(status: 'Rejected')
    else
      approve_application
    end
  end
end
