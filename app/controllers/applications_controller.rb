class ApplicationsController < ApplicationController
    def show 
        @application = Application.find(params[:id])
    end 

    def new
    end 

    def create 
        new_app = Application.create(application_params)
        new_app.update(application_status: "In Progress")
        redirect_to "/applications/#{new_app.id}"
    end

    private 
    def application_params
        application_params = params.permit(:applicant_name,
                                           :street_address,
                                           :city,
                                           :state,
                                           :zipcode,
                                           :why,
                                           :application_status)
    end 
end 