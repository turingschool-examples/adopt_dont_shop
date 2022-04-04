class PetApplicationsController < ApplicationController

  def update
    @application = Application.find(params[:id])
    # require "pry"; binding.pry
    if !params[:approve].nil?
      @pet_app = PetApplication.find(params[:approve])
      @pet_app.update(status: "Approved")
    elsif !params[:reject].nil?
      @pet_app = PetApplication.find(params[:reject])
      @pet_app.update(status: "Not Approved")
    end
    redirect_to "/admin/applications/#{@application.id}"
  end
end
