class ApplicationsController < ApplicationController

  def show 
    @application = Application.find(params[:id])
    @search_result = @application.pet_search(params[:query]) if params[:query]
  end
  
  def new
    @new_application = Application.new
  end

  def create
    @new_application = Application.create(app_params)

    if @new_application.save
      flash.notice = 'Update Successful'
      redirect_to ("/applications/#{@new_application.id}")
      status = 'In Progress'
    else
      flash.notice = 'Unsuccessful - Please Try Again'
      render :new
    end
  end

  private

  def app_params
    params.permit(:name,:street_address,:city,:state,:zip_code,:description)
  end

end