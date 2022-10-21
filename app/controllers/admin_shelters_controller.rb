class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabetize
  end
end