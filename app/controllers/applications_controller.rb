class ApplicationsController < ApplicationController

  def new
  end

  def show
    @application = Application.find(params[:id])
    @search_results = Pet.search(params[:query])
  end      
end