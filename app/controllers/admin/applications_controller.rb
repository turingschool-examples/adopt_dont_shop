module Admin
  class ApplicationsController < ApplicationController

    def show
      @application = Application.find(params[:id])
      @application_pet = ApplicationPet.find_by(application_id: params[:application_id], pet_id: params[:pet_id])
    end


  end
end
