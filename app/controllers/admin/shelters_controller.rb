class Admin::SheltersController < ApplicationController

  def index
    @shelters = Shelter.reverse_alpha_shelters
  end

  def show
    @shelter = Shelter.find_name_and_address(params[:id])
  end
end