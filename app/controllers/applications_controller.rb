class ApplicationsController <ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def new
  end

  def create
    @application = Application.create(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
    flash[:error] = "Please check your information all information must be filled in."
    render :new
    end
  end
end

  private
  def application_params
    params.permit(:name, :address, :city, :state, :zip_code, :status)
  end
