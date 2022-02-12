class PetApplicationsController < ApplicationController

  def show
    @pets = PetApplication.find(params[:id])
  end

end
