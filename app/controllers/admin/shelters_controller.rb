class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.all.rev_alpha
    @shelters_pending_app = Shelter.pending_app
  end
end