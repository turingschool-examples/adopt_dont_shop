class AdminController < ApplicationController
  
  def index
    @shelters = Shelter.find_by_sql("SELECT * FROM shelters ORDER BY name DESC")
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end
end
