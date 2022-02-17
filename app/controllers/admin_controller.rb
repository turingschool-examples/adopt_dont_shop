class AdminController < ApplicationController
  def index
    @shelters = Shelter.ordered
  end
end
