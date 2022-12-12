class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.all.sort_reverse_alpha
    @shelters_pending = Shelter.pending
  end
end