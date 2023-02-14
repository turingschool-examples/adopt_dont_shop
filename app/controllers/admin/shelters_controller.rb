class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_name_reverse
    @pending_shelters = Shelter.with_pending
  end

  
end