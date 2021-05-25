class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabet
  end
end
