class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def new
  end

  def create
    @application = Application.new(app_params)
    if @application.valid?
      @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash.now[:message] = @application.errors.full_messages[0]
      render :new
    end
  end


  private
  
  def app_params
    params.permit(:name, :street_address, :city, :state, :zip, :description, :status)
  end
end