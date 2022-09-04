class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search]
      @pets = Pet.search(params[:search])
    else
      @application = Application.find(params[:id])
    end
  end

  def new
  end

  def create
    if params[:name].blank? || params[:street_address].blank? || params[:city].blank? || params[:state].blank? || params[:zipcode].blank? || params[:status].blank?
      redirect_to "/applications/new"
      flash[:alert] = "Please fill in all fields"
    else
      application = Application.create!(new_params)

      redirect_to "/applications/#{application.id}"
    end
  end

  def update
    @application = Application.find(params[:id])
    @application.update(description: params[:description])
    @application.update(status: 'Pending')
    @application.save
    redirect_to "/applications/#{@application.id}"
  end

private
  def applications_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :status, :description)
  end

  def new_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :status)
  end

#   {name: params[:name]},
#                                 {street_address: params[:street_address]},
#                                 {city: params[:city]},
#                                 {state: params[:state]},
#                                 {zipcode: params[:zipcode]},
#                                 {status: params[:status]}
end
