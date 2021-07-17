class Applications < ApplicationRecord
  def index
    @applications = Application.all
  end

  def new
    # @application = Application.find(params[:application_id])
  end

  def create
    # application = Application.find(params[:application_id])
    # park = state.parks.create!(state_park_params)
    # redirect_to new_state_park_path(state)
  end

private
  # def state_park_params
  #   params.permit(:id, :state_id, :name, :camping_allowed, :kayaking_available, :park_rating)
  # end

end
