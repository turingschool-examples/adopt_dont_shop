class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.get_all_ordered_by_name_descending
    @shelters_pending = Shelter.get_all_pending_applications
  end
end
