class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:app_id])
  end

  def new
  end

  def create
    application = Application.new({
      name: params[:name],
      address: "#{params[:street]} #{params[:city]}, #{params[:state]} #{params[:zip]}",
      description: params[:description],
      status: "In Progress"
      })
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = "Application not created: Required information missing."
      render :new
    end
  end
end
