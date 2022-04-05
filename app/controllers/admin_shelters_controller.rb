class AdminSheltersController < ApplicationController
  def index
    @admin_shelters = Shelter.reverse_alphabetical_order
    @shelters_w_app = Shelter.shelters_w_applications
  end
end
