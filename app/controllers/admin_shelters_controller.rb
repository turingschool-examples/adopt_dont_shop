class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabet
    @pending = Shelter.with_pending
  end

  def show
    @shelter = Shelter.find(params[:id])
  end
end
