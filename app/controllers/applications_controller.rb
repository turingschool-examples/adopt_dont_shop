class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @search = true
      @pets = Pet.search(params[:search])
    end
  end

  def new
    @application = Application.new
  end

  def update
    application = Application.find(params[:id])
    application.update(update_params)
    redirect_to "/application/#{application.id}"
  end

  def create
    @application = Application.new(applicant_params)
    if @application.save
      redirect_to "/application/#{@application.id}"
    else
      render :new
    end
  end


  private

  def applicant_params
    params.required(:application).permit(:name, :street_address, :city, :state, :zipcode)
  end

  def update_params
    params.permit(:description, :status)
  end
end
