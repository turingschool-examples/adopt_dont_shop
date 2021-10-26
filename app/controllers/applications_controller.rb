class ApplicationsController < ApplicationController
    def show 
        if params["search"].present?
            application = Application.find(params[:id])
            @application = application.show_pets(application.id, params["search"]) 
        else 
            application = Application.find(params[:id])
            @application = application.application_info(application.id)
        end 
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