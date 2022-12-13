class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.all.sort_reverse_alpha
    @shelters_pending = Shelter.pending
  end

  def show
    @shelter = Shelter.find_name_and_address(params[:id])
  end
end