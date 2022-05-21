class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pet_search = Pet.search(params[:search]) if params[:search].present?

    if params["Why would you make a good owner"].present?
      @application.update(description: params["Why would you make a good owner"], status: 'Pending')
    end
  end

  def new
    @status = 'In Progress'
  end

  def create
    if Application.create(application_params).valid?
      @last_app = Application.order('created_at').last
      redirect_to "/applications/#{@last_app.id}"
    else
      redirect_to '/applications/new'
      flash[:message] = 'Please fill in all the fields'
    end
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end
