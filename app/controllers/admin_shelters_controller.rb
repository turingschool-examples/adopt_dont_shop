class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY name desc")
    @pending = Shelter.find(Pet.joins(:pet_applications).pluck(:shelter_id))
  end
end
