class AdminSheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_name_reverse
    # @shelters_with_applications = Shelter.find_by()
  end

  private
  def shelter_params
    params.permit(:id, :name, :city, :foster_program, :rank)
  end

  private
  def error_message(errors)
    errors.full_messages.join(', ')
  end
end