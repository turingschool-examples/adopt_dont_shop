class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.shelters_by_name
    @shelters_with_pending_applications = Shelter.shelters_with_pending_applications
  end
end
