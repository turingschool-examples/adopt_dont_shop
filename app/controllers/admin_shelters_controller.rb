class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("SELECT name FROM shelters ORDER BY name DESC")
    @pending_app_shelters = Shelter.joins(pets: :application_pets).joins(:applications).where(applications: {status: "Pending"}).distinct
  end
end