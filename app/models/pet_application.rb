class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def show
    @pet_application = PetApplication.find(params[:id])
  end
end
