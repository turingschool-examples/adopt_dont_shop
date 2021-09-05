class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    if params[:search].present?
      @application = Application.find(params[:app_id])
      @pets = Pet.search(params[:search])
    else
      @application = Application.find(params[:app_id])
    end
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

  def update
    application = Application.find(params[:app_id])
    application.pets << Pet.find(params[:pet])
    redirect_to "/applications/#{application.id}"
  end
end
