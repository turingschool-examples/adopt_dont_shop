class AppsController < ApplicationController
  def show
    @app = App.find(params[:id])
    @pets = @app.pets
  end
  
  def new
    
  end
end