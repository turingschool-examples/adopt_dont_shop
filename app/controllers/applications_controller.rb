class ApplicationsController < ApplicationController
  def show
    @applications = Application.all
  end


  def new
    @error = 'please fill the form in completely'
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
      redirect_to "/applications/#{Application.first.id}"
    else
      redirect_to '/application/new?error=true'
    end
  end
end
