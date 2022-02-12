class ApplicationsController < ApplicationController


  def show
    @application = Application.find(params[:id])
    @pet_application = PetApplication.find(params[:id])
    @pet = Pet.find(@pet_application.pet_id)
  end

  enum status: {
    "In Progress" => 0,
    "Pending" => 1,
    "Accepted" => 2,
    "Rejected" => 3
  }

end
