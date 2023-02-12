class Admin::SheltersController < ApplicationController

  def index
    @shelters = Shelter.sort_reverse_alphabetical
  end

end