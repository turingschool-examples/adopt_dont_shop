class AdminController < ApplicationController
  def index
    @shelters = Shelter.alphabetical_shelters
    @pending = Shelter.pending_apps
  end

  def show
    @application = Application.find(params[:id])
    require 'pry' ; binding.pry
  end
end