class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY name DESC")
    @pending = Shelter.joins(pets: :applications).where('applications.status' => "Pending")
  end
end
