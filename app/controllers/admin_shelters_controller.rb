class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.desc_alpha
  end
end