class ApplicationsController < ApplicationController

    def show 
        @application = Application.find(params[:id])
        binding.pry
    end

end