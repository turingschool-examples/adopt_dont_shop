class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])

    if params[:search] != nil
      @search_results = Pet.search_by_name(params[:search])
    end
  end

  def new
  end

  def create
    @new_app = Application.create!(name: params[:name], street_address: params[:street_address], city: params[:city], state: params[:state], zip_code: params[:zip_code], description: "", status: "In Progress")
    if @new_app[:name].empty? || @new_app[:street_address].empty? || @new_app[:city].empty? || @new_app[:state].empty? || @new_app[:zip_code].empty?
      redirect_to "/applications/new", notice: "You can not leave any of the fields blank."
    else
      redirect_to "/applications/#{@new_app[:id]}"
    end
  end

  def add_pet
    ApplicationPet.create!(pet_id: params[:chosen_pet], application_id: params[:id])
    application = Application.find(params[:id])
    application.description = params[:description]
    application.save
    redirect_to "/applications/#{params[:id]}"
  end

  def submit_application
    application = Application.find(params[:id])
    application.description = params[:description]
    application.status = "Pending"
    application.save
    redirect_to "/applications/#{params[:id]}"
  end
end
