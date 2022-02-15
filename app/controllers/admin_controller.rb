class AdminController < ApplicationController

  def shelters
    @shelters = Shelter.all
  end

end
