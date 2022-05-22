class AdminSheltersController < ApplicationController
    def index 
        @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY shelters.name desc")
        # binding.pry
        @pending = Shelter.joins(pets: :applications).where(applications: { status: 'Pending' })
    end
end