class AdminController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabet
    @shelters_with_pending_apps = Shelter.pending_apps
  end
end
