class PetsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end
end
