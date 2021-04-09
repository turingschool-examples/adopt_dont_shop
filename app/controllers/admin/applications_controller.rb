class Admin::ApplicationsController < ApplicationController

   def show
     @application = Application.find(params[:id])
     @pets = @application.pets
   end

  def update
    @application = Application.find(params[:id])
    if (params[:name] == "Approved")
      @application.update(status: "Approved")
      redirect_to "/admin/applications/#{@application.id}"
    else
      @application.update(status: "Rejected")
      redirect_to "/admin/applications/#{@application.id}"
    end
  end
end
