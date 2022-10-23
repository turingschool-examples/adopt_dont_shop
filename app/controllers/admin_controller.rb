class AdminController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("SELECT shelters.* FROM shelters ORDER BY shelters.name DESC")
  end
end