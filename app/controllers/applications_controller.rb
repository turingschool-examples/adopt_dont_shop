class ApplicationsController < ApplicationController
  def show
    @applications = Application.find(params[:id])
    # require "pry"; binding.pry
  end

  def new
    
  end
end