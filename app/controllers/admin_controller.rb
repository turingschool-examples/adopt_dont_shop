class AdminController < ApplicationController
  def shelter
    @shelters = Shelter.order_by_name
  end

  def shelter_show
    @shelter = Shelter.find(params[:shelter_id])
  end
end
