class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabet
    @pending = Shelter.with_pending
  end
end
