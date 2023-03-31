class ApplicationsController < ApplicationController
  
  def show
    @application = Application.find(params[:id])
  # require 'pry'; binding.pry
  end
end