class ApplicationsController < ApplicationController


  def new 
    @application = Application.new
  end

  def show
    @application = Application.find(params[:id])
  end 


end
