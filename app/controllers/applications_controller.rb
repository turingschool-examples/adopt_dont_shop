class ApplicationsController < ApplicationController
    def show
        @applications = Application.all
        @pets = PetApplication.all
    end
end