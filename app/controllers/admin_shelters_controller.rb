class AdminSheltersController < ApplicationController 
    def index
        @shelters = Shelter.all
    end

    def show
        id = params[:id]
        @shelter = Shelter.find_by_sql("SELECT name, city FROM shelters WHERE #{id} = shelters.id").first
    end
    
end