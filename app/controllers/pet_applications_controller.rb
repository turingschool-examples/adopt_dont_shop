class PetApplicationsController < ApplicationController
  def show
    @app = PetApplication.find(params[:id])
  end
end
