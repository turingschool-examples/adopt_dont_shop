class AppsController < ApplicationController
  
  def new
  end

  def create
    @app = App.new(app_params)
    if @app.save
      flash[:success] = "Application Created!"
      redirect_to "/apps/#{@app.id}"
    else 
      flash[:error] = "Application Not Created, Required Information Missing" # use errors.full_messages
      redirect_to "/apps/new"
    end 
  end
  
  def show
    @app = App.find(params[:id])
    return @search_pets = Pet.search(params[:search]) if params[:search]
    @pets = Pet.search(params[:search])
  end

  def update
    @app = App.find(params[:id])
    if @app.update({ status: 1}) 
      redirect_to "/apps/#{@app.id}"
      flash[:success] = "Application submitted: Status is Pending!"
    else
      redirect_to "/apps/#{@app.id}"
      flash[:error] = "Must submit a reason for ownership!!"
    end 
    end

  private 
  def app_params
    params.permit(:name, :address, :city, :state, :zip, :description, :status)    
  end
end 