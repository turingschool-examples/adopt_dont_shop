class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_by_name
  end
end
