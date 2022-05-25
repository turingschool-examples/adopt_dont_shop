class Admin::SheltersController < ApplicationController

  def index
    @shelters = Shelter.rev_alpha
  end
end