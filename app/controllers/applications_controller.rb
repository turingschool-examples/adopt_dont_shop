class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:petsearch] != nil
      @pets = Pet.petsearch(params[:petsearch])
    end
    if params[:pet] != nil
     ApplicationPet.create!(application_id: @application.id, pet_id: params[:pet].to_i, status: true)
    end
      
  end

  def new; end

  def create
    @application = Application.new(first: params[:first], last: params[:last], street: params[:street],
                                   city: params[:city], state: params[:state], zip: params[:zip], description: params[:description], status: 'Pending')
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to '/applications/new'
      flash[:alert] = 'Error, fill in all fields'
    end
  end
end
