class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.get_all_ordered_by_name_descending
  end
end
