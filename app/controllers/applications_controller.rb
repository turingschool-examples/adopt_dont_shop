class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    new_application = Application.create!(application_params)
    redirect_to "/applications/#{new_application.id}"
  end

  private
    def application_params
      params.permit(
                    :name,
                    :street_address,
                    :city,
                    :state,
                    :zipcode,
                    :description,
                    :pet_names,
                    :status)
    end
end
