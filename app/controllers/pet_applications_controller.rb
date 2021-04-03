class PetApplicationsController < ApplicationController

  def index
    @pet_applications = PetApplication.all
  end

end
