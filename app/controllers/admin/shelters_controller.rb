class Admin::SheltersController < ApplicationController

  def index
    @shelters = Shelter.reverse_alphabetical_by_name

    @shelters_with_pending_applications = Shelter.pending_applications
  end
end
