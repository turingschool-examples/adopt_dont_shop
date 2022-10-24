class AdminSheltersController < SheltersController
  def index
      @shelters = Shelter.order_alphabatically_in_reverse
      @shelters_with_pending_apps = Shelter.shelters_with_pending_applications
  end
end