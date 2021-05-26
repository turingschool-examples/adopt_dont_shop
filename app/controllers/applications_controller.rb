class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])

    if params[:seek_adoption] && @application.pets.include?(Pet.find(params[:seek_adoption]))
      flash[:notice] = "You have already selected this pet!"
    elsif params[:seek_adoption] && !@application.pets.include?(Pet.find(params[:seek_adoption]))
      @application.pet_to_adopt(Pet.find(params[:seek_adoption]))
      @application.pets
    elsif params[:search]
      @pets_search = Pet.adoptable.search(params[:search])
    elsif @application.status == 'Pending'
      @pets = @application.pets
    end
  end

  def new
    @application = Application.new
  end

  def create
    @application = Application.new(application_params)
# binding.pry
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash[:notice] = "Please fill out necessary fields for submission!"
      redirect_to '/applications/new'
      # render :new
    end
  end

  def update
    application = Application.find(params[:id])
    application.status = params[:status]
    application.description = params[:reason]
    application.save!
    redirect_to "/applications/#{application.id}"
  end

  private

  def application_params
    params.require(:application).permit(
      :first_name,
      :middle_name,
      :last_name,
      :street_number,
      :street_prefix,
      :street_name,
      :street_type,
      :city,
      :state,
      :zip_code,
      :description,
      :status
    )
  end
end
