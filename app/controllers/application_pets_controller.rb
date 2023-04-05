class ApplicationPetsController < ApplicationController

  def new
    ApplicationPet.create!(application_id: params[:application_id], pet_id: params[:id])
    redirect_to "/applications/#{params[:application_id]}"
  end

  def update
    app.update_status(params)
    redirect_to "/admin/applications/#{params[:id]}"
  end

  private

  def app
    Application.find(params[:id])
  end
end