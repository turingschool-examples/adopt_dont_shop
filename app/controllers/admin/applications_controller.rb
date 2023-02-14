class Admin::ApplicationsController < ApplicationController

  def show
    @applications = Application.all
    @pending_applications = Application.all.where(applications: {app_status: 1})
    @app = Application.find(params[:id])
  end
  
  def update
    @app = Application.find(params[:id])
    @app.update(app_status: 2)
    redirect_to "/admin/applications/#{@app.id}"
  end

  private
  def admin_app_params
    params.permit(:app_status)
  end
end