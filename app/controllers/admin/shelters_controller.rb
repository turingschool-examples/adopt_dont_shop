class Admin::SheltersController < ApplicationController

  def index
    @shelters = Shelter.order_by_reverse_alphabetical 
  end
end
