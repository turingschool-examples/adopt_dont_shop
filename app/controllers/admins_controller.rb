class AdminsController < ApplicationController

  def shelter_index
    @all_shelters = Shelter.reverse_alph
    @app_shelters = Shelter.open_apps
  end

  def application_show
    @application = Application.find(params[:id])
  end

  def application_pet_condition_change
    PetApplication.find(params[:id]).change_condition(params[:condition_update])
    redirect_to "/admin/applications/#{PetApplication.find(params[:id])[:application_id]}"
  end
end