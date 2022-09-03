class AdminApplicationsController < ApplicationController

  def show
    @pending_pets = PetApplication.pending_pets
  end
end