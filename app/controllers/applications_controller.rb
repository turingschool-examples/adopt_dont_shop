class ApplicationsController < ApplicationController
def show
  # require "pry"; binding.pry
   @app = Application.find(params[:application_id])
   # require "pry"; binding.pry
end

end 
