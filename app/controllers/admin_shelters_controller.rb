class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.find_by_sql("select name from shelters order by name desc")
  end
end