class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pet_id_pairs = @application.pets.pluck(:id, :name)
    # require 'pry'; binding.pry
  end
  
  def update
    application = Application.find(params[:id])
    application.update
    require 'pry'; binding.pry
  end
end
