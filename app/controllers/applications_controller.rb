class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])

    if params[:search].present?
      @pets = Pet.search(params[:search])
    end
  end

  def new

  end

  def create
    Application.create(name: params[:name],
                      address: params[:street_address],
                      city: params[:city],
                      state: params[:state],
                      zip: params[:zip_code],
                      description: params[:description],
                      status: params[:status])

    new_application = Application.last
    redirect_to "/applications/#{new_application.id}"
  end

end
