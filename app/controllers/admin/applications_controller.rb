class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    # require "pry"; binding.pry
    if @application.pet_applications.all_approved?
      @application.update(status: "Approved")
    end

  end
end
