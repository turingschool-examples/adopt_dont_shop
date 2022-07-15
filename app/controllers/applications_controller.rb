class ApplicationsController < ApplicationController
 def index
   @applications = Application.all
 end

 def show
   require "pry"; binding.pry
   @application = Application.find(params[:id])
 end
end
