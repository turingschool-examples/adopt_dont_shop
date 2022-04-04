class AdminSheltersController < ApplicationController

  def index
    @shelters = Shelter.order_by_reverse_alpha
    @pending = Shelter.pending
  end

  def show
    shelter = Shelter.find(params[:id])
    @shelter_info = Shelter.show_list(params[:id])
    @adoptablepetscount = shelter.adoptable_pets.count
    @avg_age = shelter.adoptable_aver_age
  end

end
