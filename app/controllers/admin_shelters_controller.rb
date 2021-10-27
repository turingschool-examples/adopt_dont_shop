class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.all.pending_applications
  end
end
