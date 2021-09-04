class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end


  def new
    @error = 'please fill the form in completely' if params[:error] != nil
  end

  def create
    # require "pry"; binding.pry
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
      redirect_to '/application/new?error=true'
    end
  end
end
