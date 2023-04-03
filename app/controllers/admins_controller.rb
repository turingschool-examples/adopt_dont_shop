class AdminsController < ApplicationController

  def shelter_index
    @all_shelters = Shelter.reverse_alph
    @app_shelters = Shelter.open_apps
  end

  def application_show
    @application = Application.find(params[:id])
    @pet_applications = @application.find_pet_apps
  end

  def application_pet_condition_change
    @pet_application = PetApplication.find(params[:pet_app]).change_condition(params[:condition_update])
    @application = Application.find(params[:id])
    @application.update_status
    redirect_to "/admin/applications/#{@application.id}"
  end
end