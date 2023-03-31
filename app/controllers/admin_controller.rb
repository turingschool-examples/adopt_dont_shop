class AdminController < ApplicationController
  def shelters_index
    @shelters = Shelter.all
    @pets = Pet.all
  end
end