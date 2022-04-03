class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if @application.all_pets_approved?
      @application.update(status: "Approved")
    end
  end
end
