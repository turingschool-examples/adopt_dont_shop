class AdminSheltersController < ApplicationController 
    def index
        @shelters = Shelter.all
    end

    def show
        @shelter = Shelter.find(params[:id])    
    end
    
end