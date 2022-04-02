class ApplicationsController < ApplicationController
  def show
    if params[:search] == "name"
      # require "pry"; binding.pry
    else
     @application = Application.find(params[:id])
    end
  end

  def new
    @application = Application.new
  end

  def create
    # @application = Application.create!(app_params)
    @application = Application.new({
      name: params[:name],
      address: params[:address],
      description: params[:description],
      pet_names: params[:pet_names],
      status: params[:status].to_i,
      })

    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash[:notice] = "Please fill in all fields"
      redirect_to "/applications/new"
    end
  end

  private
    def app_params
      # require "pry"; binding.pry
      params.permit(:name, :address, :description, :pet_names, :status)
    end


end
