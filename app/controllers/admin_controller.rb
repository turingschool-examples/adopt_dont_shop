class AdminController < ApplicationController
  def shelters_index
    @shelters = Shelter.order_alpha
    @pets = Pet.all
    @shelters_pending = Shelter.join_application_pending
  end

end