class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_abc_order
  end

  private

  def shelter_params
    params.permit(:id, :name, :city, :foster_program, :rank)
  end
end
