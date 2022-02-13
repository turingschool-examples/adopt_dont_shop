class ApplicationsController < ApplicationController

  def new
  end

  def create
    new_app = Application.create(application_params)
    redirect_to "/applications/#{new_app.id}"
  end

  def show
    @application = Application.find(params[:id])
  end

  private

  def application_params
    params.permit(:id, :first_name, :last_name, :street_address, :city, :post_code, :good_owner)
  end

end
