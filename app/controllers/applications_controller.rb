class ApplicationsController < ApplicationController
    def show
        @applications = Application.all
    end
end