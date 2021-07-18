class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def new

  end

  def create
    @application = Application.new(application_params)
    if @application.valid?
      @application.save
      flash[:notice] = "Application Saved Successfully"
      redirect_to "/applications/#{@application.id}/"
    else
      redirect_to "/applications/new/"
      # render "/applications/new/"
      # , notice: "#{error_message(@application.errors)}"
      flash[:notice] = "Error: #{error_message(@application.errors)}"
    end
  end

  def edit
    @application = Application.find(params[:id])
  end

  def show
    @application = Application.find(params[:id])
  end

  def destroy
    @application = Application.find(params[:id])
    @application.destroy
    redirect_to '/applications'
  end

private
  def application_params
    params.permit(:name, :application_status, :street, :city, :state, :zip_code, :description)
  end


end
