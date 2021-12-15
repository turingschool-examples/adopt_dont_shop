class AdminsController < ApplicationController
  def index
  end

  def show
    @shelters = Shelter.all
  end
end
