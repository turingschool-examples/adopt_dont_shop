class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.shelters_by_name
  end
end
