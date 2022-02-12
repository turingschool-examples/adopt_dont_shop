class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def new
    @application = Application.new
  end

  def create
    @application = Application.new(applicant_params)
    if @application.save
      redirect_to "/application/#{@application.id}"
    else
      render :new
    end
  end


  private

  def applicant_params
    params.required(:application).permit(:name, :street_address, :city, :state, :zipcode)
  end
end
#
# if application.save
#   redirect_to "/application/#{application.id}"
# else
#   flash[:alert] = "Please fill in all information"
#   render :new
# end
