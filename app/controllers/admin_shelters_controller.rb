class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("SELECT shelters.* FROM shelters ORDER BY name DESC")
    # binding.pry
    @pending_applications = Shelter.pending_applications

  end
end