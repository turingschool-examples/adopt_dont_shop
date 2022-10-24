class AdminSheltersController < ApplicationController
  def index
    # @shelters = Shelter.all.order(name: :desc)
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY name DESC")
    @pending_shelters = Shelter.joins(pets: :applications).uniq
  end
end
