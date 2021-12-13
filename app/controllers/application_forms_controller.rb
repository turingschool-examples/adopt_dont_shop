class ApplicationFormsController < ApplicationController
  def index
    @application_forms = ApplicationForm.all
  end

  def show
    @application_form = ApplicationForm.find(params[:id])
  end

  def new
  end

  def create
    application = ApplicationForm.new(application_params)
    if application.save
      flash[:notice] = "Your application has been submitted"
      redirect_to "/application_forms/#{params[:id]}"
    else
      redirect_to "/application_forms/new"
      flash[:notice] = "Your form is not complete"
    # ApplicationForm.create(name: params[:name],
    #                        street_address: params[:street_address],
    #                        city: params[:city],
    #                        state: params[:state],
    #                        zip_code: params[:city],
    #                        description: params[:description])

  end
end

private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
