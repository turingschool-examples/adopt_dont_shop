class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    # binding.pry
    if params[:search] != nil
      @search_results = Pet.search_by_name(params[:search])
      binding.pry
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

end
