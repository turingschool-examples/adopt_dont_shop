class AdminController < ApplicationController
  def shelters_index
    @shelters = Shelter.order_reverse_alphabetically
    @pending_shelters = Shelter.order_pending_alphabetically
  end

  def shelters_show
    @shelter = Shelter.find_by_sql("SELECT id, name, city FROM shelters WHERE id=#{params[:id]}")[0]
  end

  def application_show
    @application = Application.find(params[:id])
  end
end
