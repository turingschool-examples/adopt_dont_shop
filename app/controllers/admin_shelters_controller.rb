class AdminSheltersController < ApplicationController
    def index 
        @shelters = Shelter.reverse_alphabetical_shelters
        @shelters_pending_apps = Shelter.shelters_with_pending_apps
    end 
end 