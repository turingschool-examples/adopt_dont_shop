class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabetical
    @shelters_with_applications = Shelter.pending_applications
  end

  def show
    @applicant = Applicant.find(params[:id])
    if params[:approved_pet_id]

    end
  end

  

  end

end
