class ApplicationsController < ApplicationController

    def index
        @applications = Application.all 
    end
    
    def show 
        @application = Application.find(params[:id])
    end

    def new
    end

    def create
        @application = Application.create!({
            name: params[:name],
            address: "#{params[:street_address]},#{params[:city]},#{params[:state]},#{params[:zip_code]}",
            description: params[:why_would_you_make_a_good_home],
            status: "In Progress"
            })
        redirect_to "/applications/#{@application.id}"
    end
end