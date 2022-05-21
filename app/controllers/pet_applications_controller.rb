class PetApplicationsController < ApplicationController
    def create
        # binding.pry
       redirect_to "/applications/#{params[:application_id]}" 
    end
end
