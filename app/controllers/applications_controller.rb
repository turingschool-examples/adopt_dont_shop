class ApplicationsController < ApplicationController

  def new
  end

  def create
    new_app = Application.new(application_params)

    if new_app.save
    redirect_to "/applications/#{new_app.id}"
  else
    redirect_to '/applications/new'
    flash[:alert] = "Error: #{error_message(new_app.errors)}"
  end
  end


  def show
    @application = Application.find(params[:id])
  end

  private

  def application_params
    params.permit(:id, :first_name, :last_name, :street_address, :city, :post_code, :good_owner)
  end

end
