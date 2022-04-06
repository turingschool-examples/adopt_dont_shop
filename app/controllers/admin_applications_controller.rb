class AdminApplicationsController < ApplicationController
  def show
    @app = Application.find(params[:id])
  end

end 
