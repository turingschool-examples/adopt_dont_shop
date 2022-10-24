class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabetize
    @pending_shelters = Shelter.with_pending_applications
  end
end