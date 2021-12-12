class AppsController < ApplicationController
  
  def new
  end

  def create
    @app = App.new(app_params)
    if @app.save
      redirect_to "/apps/#{@app.id}"
    else 
      flash[:error] = "Application Not Created, Required Information Missing"
      redirect_to "/apps/new"
    end 
  end
  
  def show
    @app = App.find(params[:id])
    if params[:search]
      @pets = Pet.search(params[:search])
    else 
      @pets = @app.pets
    end 
  end

  private 
  def app_params
    params.permit(:name, :address, :city, :state, :zip, :description, :status)    
  end
end 