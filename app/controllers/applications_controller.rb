class ApplicationsController <ApplicationController
  def index
    @applications = Application.all
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

  def show
    @application = Application.find(params[:id])
  if params[:search]
    @pets = Pet.search(params[:search])
    end
  end

  def update
    application = Application.find(params[:id])
    application.update({
      description: params[:description],
      status: "Pending"
      })
      redirect_to "/applications/#{application.id}"
  end


  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip_code, :status)
  end
end
