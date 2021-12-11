class ApplicationsController < ApplicationController

    def index 
        @applications = Application.all 
    end

    def show 
        @application = Application.find(params[:id])
        @pets_applied_for = @application.pets
    end

end