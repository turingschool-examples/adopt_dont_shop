class Admin::SheltersController < ApplicationController
  def index
    @shelters_with_pending_apps = Shelter.pending_applications
    @shelters = Shelter.reverse_alphabetical
  end

  def show
    @shelter = Shelter.find(params[:id])
  end
end
