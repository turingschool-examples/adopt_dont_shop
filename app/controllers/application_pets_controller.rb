class ApplicationPetsController < ApplicationController

  def new
    ApplicationPet.create!(application_id: params[:application_id], pet_id: params[:id])
    redirect_to "/applications/#{params[:application_id]}"
  end

  def update
    if params[:approve_all]
      app.application_pets.update(status: 'Approved')
    else
      app.application_pets.find_by(pet_id: params[:pet_id]).update(status: params[:status].capitalize) &&
      app.update(status: params[:status].capitalize)
    end

    app.update(status: 'Approved') if app.application_pets.all_approved?
    redirect_to "/admin/applications/#{params[:id]}"
  end

  private

  def app
    Application.find(params[:id])
  end
end