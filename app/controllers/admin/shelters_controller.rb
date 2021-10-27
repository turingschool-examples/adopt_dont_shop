class Admin::SheltersController < ApplicationController
    def index 
        @shelters = Shelter.desc_order
    end 
end 