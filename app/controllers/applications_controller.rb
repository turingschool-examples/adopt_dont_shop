class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])

    if params[:name].present?
      @pets = Pet.where("Name ILIKE ?", "%#{params[:name]}%")
    else
      @pets = []
    end

    if params[:adopt_pet].present?
      pet = Pet.find(params[:adopt_pet])
      @application.pets << pet
    end

    if params[:description].present?
      @application.status = "Pending"
      @application.update(:description => "#{@application.description} #{params[:description]}")
    end
  end

  def new
  end

  def create
    application = Application.create(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:error] = "**Required content missing**"
      render :new
    end
  end

private
  def application_params
    params
      .permit(:name, :street_address, :city, :state, :zipcode, :description)
      .with_defaults(status: "In Progress")
  end
end
