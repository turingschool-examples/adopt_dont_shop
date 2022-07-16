class Admin::SheltersController < ApplicationController

  def index
    @shelters = Shelter.reverse_order
  end
end