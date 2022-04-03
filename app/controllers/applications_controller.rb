class ApplicationsController < ApplicationController
def show
   @app = Application.find(params[:id])
end

def new
end

def create 
  app = Application.create!(app_params)
  redirect_to "/applications/#{app.id}"
end

private

  def app_params
    params.permit(:id, :name, :address, :city, :state, :zipcode, :description, :app_status)
  end

end 
