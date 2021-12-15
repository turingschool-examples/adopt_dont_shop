class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabetical
    @shelters_with_applications = Shelter.pending_applications
  end

  def show
    @applicant = Applicant.find(params[:id])
    if params[:commit] == 'Submit'
      approval_status = verify_application(@applicant.pets, params)
      if approval_status == 'none'
        flash[:notice] = "Must Select Approve or Reject."
      elsif approval_status == 'double'
        flash[:notice] = 'Cannot Accept And Reject Pet. Select One Option'
      elsif approval_status == 'Rejected'
        @applicant.update({status: 'Rejected'})
      else
        @applicant.update({status: 'Approved'})
      end
    end
  end

  def verify_application(pets, params)
    pets.each do |pet|
      if params[pet.id.to_s]['approved'] == 'no' && params[pet.id.to_s]['rejected'] == 'no'
        return 'none'
      elsif params[pet.id.to_s]['approved'] == 'yes' && params[pet.id.to_s]['rejected'] == 'yes'
        return 'double'
      end
      if params[pet.id.to_s]['rejected'] == 'yes'
        return 'Rejected'
      end
    end
    'Approved'
  end
end
