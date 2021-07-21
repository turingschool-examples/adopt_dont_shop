class AdminsController < ActionController::Base

  def shelters_index
    @shelters = Shelter.order_by_reverse_alphabetical
  end
end
