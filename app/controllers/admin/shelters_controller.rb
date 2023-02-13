class Admin::SheltersController < ApplicationController

  def index
    @shelters = Shelter.find_by_sql("SELECT name FROM shelters ORDER BY name DESC")
    @shelters_pending_apps = Shelter.list_pending_apps
  end
end