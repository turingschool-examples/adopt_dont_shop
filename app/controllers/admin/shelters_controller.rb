class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabetical
    @pending_shelters = Shelter.pending_applications
  end

  def show
    @shelter = Shelter.find(params[:id])
  end
end
