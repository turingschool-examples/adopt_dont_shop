class AdminController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabet
    @shelters_with_pending_apps = Shelter.pending_apps
  end

  def show
    @applicant = Applicant.find(params[:id])
    @full_address = "#{@applicant.address_line_1} #{@applicant.city}, #{@applicant.state} #{@applicant.zipcode}"
  end

  def update
    if params[:approve]
      pet_app = PetApplication.find(params[:approve])
      pet_app.Accepted!
    else
      pet_app = PetApplication.find(params[:reject])
      pet_app.Rejected!
    end
    redirect_to "/admin/applications/#{params[:id]}"
  end
end
