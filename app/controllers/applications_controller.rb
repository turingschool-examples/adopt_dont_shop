class ApplicationsController < ApplicationController

    def index 
        @applications = Application.all 
    end

    def show 
        @application = Application.find(params[:id])
        @pets_applied_for = @application.pets

        # if params[:status] == "in progress"

    end

    def new

    end

    def create
        @application = Application.create(application_params)
        @application.status = "in progress"

        if @application.save
            flash[:success] = "Thanks for applying to save a life!"
            redirect_to "/applications/#{@application.id}"
        else 
            flash[:alert] = "Error: #{error_message(@application.errors)}"
            redirect_to "/applications/new"
        end
    end

private
    def application_params
        params.permit(:name, :address, :city, :state, :zip, :reason, :status)
    end

end
