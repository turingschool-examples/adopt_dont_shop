class PetApplication < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  def create
    @application = Application.find(params[:id])
    @pet = Pet.find_by_name(params[:pet_name])
    PetApplication.create!(application: @application, pet: @pet)
    redirect_to "/applications/#{@application.id}"
  end
end
