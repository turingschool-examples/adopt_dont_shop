class ApplicationsController < ApplicationController
  def show
    @app = Application.find(params[:id])
    @pet_search_results = []
    if params[:search_for_pet_by_name]
      @pet_search_results = Pet.search(params[:search_for_pet_by_name])
    end
  end

  def new
  end

  def create
    app = Application.new(app_params)

    if app.save
      redirect_to "/applications/#{app.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error, please fill out form"
    end
  end

  def submit_for_approval
    app = Application.find(params[:id])
    app.description = params[:description]
    app.app_status = "Pending"
    app.save
    redirect_to "/applications/#{params[:id]}"
  end

  private

  def app_params
    params.permit(:id, :name, :address, :city, :state, :zipcode, :description, :app_status)
  end
end
