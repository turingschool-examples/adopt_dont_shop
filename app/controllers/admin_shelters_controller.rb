class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.pending
  end
end