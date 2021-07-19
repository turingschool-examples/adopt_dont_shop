class PetApplications < ApplicationController
  def index
    @applications = Application.all
    @pets = Pet.all
  end
end
