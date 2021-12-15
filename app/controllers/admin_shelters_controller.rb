class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.all.reverse_alfa
  end
end 