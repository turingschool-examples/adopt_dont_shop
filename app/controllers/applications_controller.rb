class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:pet_name]
      @pets = Pet.search_for(params[:pet_name])
    end
  end


  def new
  end

  def create
    application = Application.new(app_params)

    if application.save
      flash[:submitted] = 'Application Submitted!'
      redirect_to "/applications/#{application.id}"
    else
      flash[:incomplete] = 'All * fields must be filled in'
      redirect_to "/applications/new"
    end
  end

  def update
    application = Application.find(params[:id])
    application.update(description: params[:description], status: 'Pending')
    redirect_to "/applications/#{application.id}"
end

  private

  def app_params
    params.permit(:id, :name, :address, :city, :state, :zip)
  end
end
