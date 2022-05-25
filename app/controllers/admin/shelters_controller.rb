class Admin::SheltersController < ApplicationController

  def index
    @shelters = Shelter.rev_alpha
    @shelters_pending = Shelter.pending_applications
  end
end