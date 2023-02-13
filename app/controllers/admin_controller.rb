class AdminController < ApplicationController
  def shelters_index
    @shelters = Shelter.order_by_name_reverse
    @pending_shelters = Shelter.with_pending
  end

  def applications_show
    
  end
end
