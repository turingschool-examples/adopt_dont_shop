class ApplicationsController < ApplicationController
  def show
    binding.pry
    @application = Application.find(params[:id])
    # binding.pry
  end
end