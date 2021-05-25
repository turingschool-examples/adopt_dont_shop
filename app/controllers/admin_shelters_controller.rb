class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.names_sorted
    @applications_pending = Application.pending
    # binding.pry
  end
end
