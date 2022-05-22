class Admin::ShelterController < ApplicationController

  def index
    @shelters = Shelter.order_by_name
  end
end
