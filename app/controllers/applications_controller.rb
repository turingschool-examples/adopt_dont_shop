class ApplicationsController < ApplicationController

    def show
        @application = Application.find(params[:application_id])
        if params[:search] != nil 
            @pets = Pet.find_by_name(params[:search])
        else     
            @pets = []
        end 
    end

end  