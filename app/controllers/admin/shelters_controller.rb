class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end
end