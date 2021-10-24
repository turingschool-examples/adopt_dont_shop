class AdminController < ApplicationController
  def shelters
    @shelters = Shelter.order_reverse_alphabetically
  end

  def applicant_show
    @application = Application.find(params[:id])
  end
end
