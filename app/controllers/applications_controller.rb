class ApplicationsController < ApplicationController
  def show
    binding.pry
    @application = Application.find_by(params[:id])
  end
end