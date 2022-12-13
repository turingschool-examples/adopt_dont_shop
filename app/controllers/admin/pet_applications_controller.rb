class Admin::PetApplicationsController < ApplicationController
  def update
    pa = PetApplication.where(pa_params).first
    pa.update(update_params)
    @application = Application.find(params[:id])
    @pets = @application.pets

    @application.status_update(pa_params)
    # if approved
    #   @application.update!(status: "Approved")
    #   adopt_pets
    # end
    # @application.update!(status: "Rejected") if rejected

    redirect_to "/admin/applications/#{pa.application_id}"
  end
  
  private
  
  def pa_params
    { pet_id: params[:pet_id], application_id: params[:id] }
  end
  
  def update_params
    { status: params[:approve] }
  end

  # def check_approved
  #   @application.pet_applications.pluck(:status)
  # end

  # def approved
  #   check_approved.all? { |status| status == 'true' }
  # end

  # def rejected
  #   check_approved.include?('false') && check_approved.include?(nil) == false
  # end

  # def adopt_pets
  #   @pets.each do |pet|
  #     pet.update!(adoptable: false)
  #   end
  # end
end
