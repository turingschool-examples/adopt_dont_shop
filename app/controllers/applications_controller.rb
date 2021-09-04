class ApplicationsController < ApplicationController
  def show
    # require "pry"; binding.pry
    @applications = Application.all
  end


  def new
  end

  def create
    # require "pry"; binding.pry
    Application.create!(name: params[:name],
      street_address: params[:address],
      city: params[:city],
      state: params[:state],
      zip: params[:zip],
      status: 'In Progress'
    )

    redirect_to "/applications/#{Application.first.id}"
  end
end
