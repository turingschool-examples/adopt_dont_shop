class ApplicationsController < ApplicationController
  def index
  end

  def show
    @applicant = Application.find(params[:id])
  end

  def new;end

  def create
    if params.has_value?("")
      redirect_to "/applications/new"
      flash[:alert] = "Error: Please fill out all required fields"
    else
      @app = Application.create!(
        name: params[:name],
        street_address: params[:street_address],
        city: params[:city],
        state: params[:state],
        zipcode: params[:zipcode],
        status: "Pending",
        description: "None"
      )
      redirect_to "/applications/#{@app.id}"
    end
  end


  # private
  #   def applications_params
  #     params.permit(:name, :street_address, :city, :state, :zipcode, status: "pending", description: "none")
  #   end
end
