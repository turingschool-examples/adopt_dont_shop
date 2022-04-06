class Admin::SheltersController < ApplicationController

  def index
    @shelters = Shelter.order_by_reverse_alphabetical
    @shelters_pending = Shelter.pending_applications
  end
end
