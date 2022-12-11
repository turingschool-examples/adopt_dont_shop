class AdminController < ApplicationController
  def shelters_index
   
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY name desc")
    pending_applications = Application.pending_application
    require 'pry'; binding.pry

  end

end