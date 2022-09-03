class AdminApplicationsController < ApplicationController

  def show
    require 'pry' ; binding.pry
    @pending_pets 
  end
end