class AdminsController < ApplicationController

  def shelter_index
    @all_shelters = Shelter.reverse_alph
    @app_shelters = Shelter.open_apps
  end

  def application_show
    @application = Application.find(params[:id])
  end

  def application_pet_condition_change
    @pet_application = PetApplication.find(params[:id]).change_condition(params[:condition_update])
    @application = PetApplication.find(params[:id]).application
    @application.update_status
    redirect_to "/admin/applications/#{PetApplication.find(params[:id])[:application_id]}"
  end
end