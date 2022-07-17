class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_reverse_alphabetical_by_name
  end
end