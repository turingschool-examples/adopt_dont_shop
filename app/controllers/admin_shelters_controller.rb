class AdminSheltersController < ApplicationController 

  def index 
    @shelters = Shelter.all.reverse_alpha_name
  end 
end 