class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    else
      @pets = []
    end
  end


  def new
  end

  def create
    @application = Application.create(name: params[:name],
      street_address: params[:address],
      city: params[:city],
      state: params[:state],
      zip: params[:zip],
      status: 'In Progress'
    )

    if @application.valid?
      @application.save
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to '/application/new'
      flash[:alert] = "please fill the form in completely"
    end
  end

  def update
    app = Application.find(params[:id])
    app.update(description: params[:description], status: 'Pending')
    redirect_to "/applications/#{params[:id]}"
  end
end
