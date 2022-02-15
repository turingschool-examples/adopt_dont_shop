class AdminSheltersController < ApplicationController
    def index 
        @shelters = Shelter.reverse_alphabetical_shelters
        @shelters_pending_apps = Shelter.shelters_with_pending_apps
    end 

    def show
        @shelter = Shelter.find(params[:id])
        @shelter_name_and_address = Shelter.name_and_full_address(@shelter)
    end 
end 