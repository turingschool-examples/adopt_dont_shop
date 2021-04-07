class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    user = User.create(user_params)
    application = Application.new(description: application_params[:description],
                                  user_id: user.id)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to '/applications/new'
      flash[:alert] = "Error: Please Fill in All Fields"
    end
  end

  private

  def application_params
    params.permit(:user_id, :description, :status)
  end

  def user_params
    params.permit(:id, :full_name, :street_address, :city, :state, :zipcode)
  end
end
