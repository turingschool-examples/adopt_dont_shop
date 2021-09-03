class ApplicationsController < ApplicationController
  def show
    # require "pry"; binding.pry
    @applications = Application.all
  end

end
