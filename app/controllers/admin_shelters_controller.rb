class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabetical
    @shelters_with_applications = Shelter.pending_applications
  end
end
