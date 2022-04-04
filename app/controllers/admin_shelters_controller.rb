class AdminSheltersController < ApplicationController

  def index
    @shelters = Shelter.order_by_reverse_alpha
    @pending = Shelter.pending
  end

  def show
    @shelter = Shelter.show_list(params[:id])
    @shelterpets = Shelter.find(params[:id])
  end

end
