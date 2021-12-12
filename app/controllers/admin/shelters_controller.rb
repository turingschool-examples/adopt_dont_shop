class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.alpha_order
    @applications = Application.pending_applications
  end
end