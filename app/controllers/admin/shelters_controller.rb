class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.rev_alphabetize
    @pending = Shelter.shelters_with_pending_apps
  end
end
