class OwnerApplicationsController < ApplicationController

  def show
    @application = OwnerApplication.find(params[:id])
  end


end
