class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end
end
