class AdminController < ApplicationController
    def index 
        @shelters = Shelter.reverse_alphabetical_shelters
    end 
end