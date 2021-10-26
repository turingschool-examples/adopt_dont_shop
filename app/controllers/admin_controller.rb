class AdminController < ApplicationController
  def shelters
    @shelters = Shelter.order_reverse_alphabetically
  end

  def application_show
    @application = Application.find(params[:id])
  end
end
