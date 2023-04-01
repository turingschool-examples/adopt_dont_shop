class Admin::SheltersController < ApplicationController

  def index
    @shelters = Shelter.reverse_alpha_shelters
  end
end