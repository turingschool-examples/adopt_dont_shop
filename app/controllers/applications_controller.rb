class ApplicationsController < ApplicationController
  def show
  @application = Application.find(params[:id])
      if params[:pet_name]
        @pets = Pet.search(params[:pet_name])
      elsif params[:pet_id]
        pet = Pet.where(id: params[:pet_id])
        @application.pets << pet
        @pets = []
        redirect_to application_show_url
      else
        @pets =[]
    end
  end

  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Please fill all fields"
      redirect_to '/applications/new'
    end
    # if filled_in?(applications_params)
    #   redirect_to '/applications/new', notice: "Please fill all fields"
    # else
    #   application = Application.create!(applications_params)
    #   redirect_to "/applications/#{application.id}"
    # end
  end

  private
  def application_params
    params.permit(:name, :address_street, :address_city, :address_state, :address_zip_code, :description, :status)
  end

  # def filled_in?(params)
  #   x = []
  #   params.each do |param|
  #   x << param[1].empty?
  #   end
  #   x.include?(true)
  # end
end
