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
    application.save
    redirect_to "/applications/#{application.id}"
  end
end
