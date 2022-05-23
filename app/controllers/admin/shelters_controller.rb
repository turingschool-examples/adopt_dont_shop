class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.rev_alphabetize
  end
end
