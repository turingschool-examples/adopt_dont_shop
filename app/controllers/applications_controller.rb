class ApplicationsController < ApplicationController

  def new
  end

  def show
    @application = Application.find(params[:id])
  end
end
