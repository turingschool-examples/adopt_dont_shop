class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.shelters_by_name
    @applications = Application.pending_applications
  end
end
