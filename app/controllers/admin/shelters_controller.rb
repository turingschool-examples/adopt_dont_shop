class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.all.rev_alpha
  end
end