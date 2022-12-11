class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.all.sort_reverse_alpha
  end
end