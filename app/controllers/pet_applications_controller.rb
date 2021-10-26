class PetApplicationsController < ApplicationController
  def index
    redirect_to action: "show", id: params[:search]
  end

  def show
    @app = PetApplication.find(params[:id])
  end
end
