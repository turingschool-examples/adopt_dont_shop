class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    @application = Application.new(new_application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      render :new
    end
  end

  def update
    if !params[:description]
      flash[:notice] = "Error: Applicant must answer all questions before submitting application"
      render :show
    else
      Application.update(params[:id], description: params[:description], status: "Pending")
      redirect_to "/applications/#{params[:id]}"
    end
  end

  private

  def new_application_params
    {
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      status: "In Progress"
    }
  end

end
