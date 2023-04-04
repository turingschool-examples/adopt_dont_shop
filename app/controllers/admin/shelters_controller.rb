class Admin::SheltersController < ApplicationController

  def index
    @shelters = Shelter.reverse_alpha_shelters
    @pending_app_shelters = Shelter.pending_app_shelters
  end

  def show
    @shelter = Shelter.find_name_and_address(params[:id])
  end

  private
  def shelter_params
    params.permit(:id, :name, :city, :foster_program, :rank)
  end
end