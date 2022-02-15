class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alph 
  end
end
