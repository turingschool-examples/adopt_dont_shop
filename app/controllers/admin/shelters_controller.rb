# app/controllers/admin/shelters_controller

class Admin::SheltersController < ApplicationController 
  # before_action  :require_admin
  def index
    @shelters = Shelter.order_by_reverse_alphabetical
  end

  # def require_admin 
  #   unless current_user.admin?
  #     redirect_to "/shelters"
  #   end
  # end
end