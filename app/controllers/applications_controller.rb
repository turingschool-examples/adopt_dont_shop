class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    @new_app = Application.create!(name: params[:name], street_address: params[:street_address], city: params[:city], state: params[:state], zip_code: params[:zip_code], description: "", status: "In Progress")
    redirect_to "/applications/#{@new_app[:id]}"
  end
  
end
