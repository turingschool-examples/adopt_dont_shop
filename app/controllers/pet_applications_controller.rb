class PetApplicationsController < ApplicationController
  def index
    redirect_to action: "show", id: params[:search]
  end

  def show
    @app = PetApplication.find(params[:id])
  end

  def new
  end

  def create
    app = PetApplication.create(app_params)

    if app.save
      flash[:success]
      redirect_to "/applications/#{app.id}"
    else
      flash[:notice] = "Error: Please fill in all fields"
      redirect_to '/applications/new'
    end
  end

  private

  def app_params
    params.permit(:name, :street, :city, :state, :zip, :reason)
  end
end
