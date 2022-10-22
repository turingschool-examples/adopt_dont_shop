class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets

    if params[:approve] == "true"
      @approved = true
    elsif params[:approve] == "false"
      @approved = false
    end
  end
end
