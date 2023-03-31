class ApplicationsController < ApplicationController

  def new
  end

  def show
    @application = Application.find(params[:id])
    if params[:query]
      @search_results = Pet.search(params[:query])
    end
  end      
end