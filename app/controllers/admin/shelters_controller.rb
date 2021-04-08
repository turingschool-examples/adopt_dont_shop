class Admin::SheltersController < ApplicationController

  def index
    @shelters = Shelter.reverse_sort
    @pending_shelters = Shelter.status_pending
  end
end
