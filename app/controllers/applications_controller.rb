class ApplicationsController < ApplicationController


  def new
    @application = Application.new
  end

  def create
    application = Application.create(app_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: all requested areas must be filled!"
    end
  end

  def show
    @application = Application.find(params[:id])
    if params[:search_by_name]
      @pet_found = Pet.search_by_name(params[:search_by_name])[0]
    end
    if params[:description]
      @application.status = "Pending"
    end
  end



private

  def app_params
    params.require(:application).permit(:name, :street_address, :city, :state, :zipcode, :status, :description)
  end
end
