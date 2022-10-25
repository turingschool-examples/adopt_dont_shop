class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_name_reverse
    @shelters_with_applications = Application.applications_by_shelter
  end
end