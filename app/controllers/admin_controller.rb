class AdminController < ApplicationController
  def shelters_index
    @shelters = Shelter.reverse_alphabetical_order
  end

  def shelters_show
    @shelter = Shelter.shelter_from_id_sql(params[:id])
  end
end