class Admin::SheltersController < ApplicationController

  def index
    @shelters = Shelter.reverse_alpha_shelters
    @pending_app_shelters = Shelter.pending_app_shelters
  end
end