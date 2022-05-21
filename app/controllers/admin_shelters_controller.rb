class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.reverse_alpha
    @shelters_with_pending = Application.pending_apps
  end
end
