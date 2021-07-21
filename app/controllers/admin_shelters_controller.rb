class AdminSheltersController < ApplicationController

  def index
    @shelters = Shelter.alphabetize_name
  end
end
