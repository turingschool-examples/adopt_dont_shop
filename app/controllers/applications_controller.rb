class ApplicationsController < ApplicationController

  def create
    @application = Application.new(application_params)
    if @application.valid?
      @application.save!
      redirect_to action: "show", id: @application.id
    else
      flash[:notice] = "Warning - You must fill in all fields before beginning your application!"
      redirect_to "/applications/new"
    end
  end

  def new
    @application = Application.new
  end

  def show
    @application = Application.find(params[:id])
    if params[:search].nil?
      @pets = Pet.adoptable
    else
      @pets = Pet.search_by_name(params[:search])
    end
    @pets_adopting = @application.pets
    # @source = 'applications'
  end

  def update
    application = Application.find(params[:id])
    application.update(statement: params[:statement],
                       status: 'Pending')
    application.save
    redirect_to "/applications/#{params[:id]}"
  end

  private
  def application_params
      params.permit(:name,
                    :street_address,
                    :city,
                    :state,
                    :zip_code,
                    :status)
  end
end