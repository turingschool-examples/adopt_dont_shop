class PetApplicationsController < ApplicationController

  def update
    # require "pry"; binding.pry
    @pet_app = PetApplication.find(params[:approve])
    @pet_app.update(status: "Approved")
    @application = Application.find(params[:id])
    redirect_to "/admin/applications/#{@application.id}"
  end
end
