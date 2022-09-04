module Admin
  class ApplicationsController < ApplicationController
    def show
      @application = Application.find(params[:id])
      @pet_apps = @application.application_pets
    end
  end
end
