class ApplicationsController < ApplicationController
    def index
        @applications = Application.all
    end

    def show
        @application = Application.find(params[:id])
        @pets = @application.pets
    end

    def new
    end

    def create
        # Application.create
    end
end
