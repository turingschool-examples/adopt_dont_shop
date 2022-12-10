class ApplicationsController < ApplicationController
  def new
    
  end

  def show
    @application = Application.find(params[:id])
  end

  def create 
    application = Application.create(
      permitted_params.merge({status: "In Progress"})
    )

    redirect_to "/applications/#{application.id}"
  end

  private

  def permitted_params
    params.permit(
      :human_name,
      :street_address,
      :city,
      :state,
      :zip,
      :description
    )
  end
end