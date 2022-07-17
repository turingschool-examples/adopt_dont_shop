class Admin::SheltersController < ApplicationController

    def index 
        @shelters = Shelter.order_by_name 
        @pending_shelters = Shelter.apps_pending
    end 
end