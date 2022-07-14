class ApplicationsController < ApplicationController

    def new 
    end

    def create
        application = Application.create!(application_params)
        redirect_to "/applications/#{application.id}"
    end

    def show
        @application = Application.find(params[:application_id])
    end

    private
    def application_params
        params.permit(:name, :street, :city, :state, :zipcode, :description)
    end 

end  