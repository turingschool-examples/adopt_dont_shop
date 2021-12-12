class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
#   #   # organized_shelters = shelters.
  end
end
