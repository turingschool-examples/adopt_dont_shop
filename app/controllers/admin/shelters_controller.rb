class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alpha_names
    @pending = Shelter.pending_apps
  end

  def show
    @shelter = Shelter.name_and_city(params[:id]).first
  end
end
