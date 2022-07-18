class ApplicationController < ActionController::Base
  before_action :set_query

  def set_query
    @query = Pet.ransack(params[:q])
  end

  def welcome
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
