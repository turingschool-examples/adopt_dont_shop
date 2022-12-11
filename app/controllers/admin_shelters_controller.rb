class AdminSheltersController < ApplicationController 

  def index 
    @shelters = Shelter.all.reverse_alpha_name
    @pending = Shelter.pending_applications
  end 
end 