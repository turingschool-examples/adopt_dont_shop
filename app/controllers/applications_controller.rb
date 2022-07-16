class ApplicationsController < ApplicationController
 def index
   @applications = Application.all
 end

 def show
      @application = Application.find(params[:id])
      # require "pry"; binding.pry
      # @pets = @application.applicant_pets
    # else
    #   @application = Application.find(params[:id])
    # end
 end
end
