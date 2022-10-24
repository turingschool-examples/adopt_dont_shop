class AdminController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabetical
    @shelters_with_pending_applications = Pet.with_pending_applications
    
  
  end

end