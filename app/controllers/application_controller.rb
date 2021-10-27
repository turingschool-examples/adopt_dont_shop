class ApplicationController < ActionController::Base
  def welcome
  end

  # def error_message(object)
  #   object.errors.full_messages.to_sentence
  # end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
