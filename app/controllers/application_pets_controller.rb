class ApplicationPetsController < ActionController::Base

  def show
    @applicant = Application.find(params[:id])
    @pet = Pet.find(params[:id])
  end
end