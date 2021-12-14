class Admin::SheltersController < ApplicationController

  def index
    @shelters = Shelter.reverse_alphabetical_by_name
  end
end
