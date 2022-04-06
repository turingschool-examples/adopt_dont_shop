class ApplicationsController < ApplicationController
  def show

    @application = Application.find(params[:id])
    if params[:pet_names]
      @pets = Pet.search(params[:pet_names])
    else
      @pets = []
    end
  end

  def new
    @application = Application.new
  end

  def create
    @application = Application.new({
      name: params[:name],
      address: params[:address],
      description: params[:description],
      pet_names: params[:pet_names],
      status: params[:status].to_i,
      })

    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash[:notice] = "Please fill in all fields"
      redirect_to "/applications/new"
    end
  end

  def update

    if params[:pet_name]
      @pet = Pet.find(params[:pet_name])

      @application = Application.find(params[:id])
      @application.update({
        name: params[:name],
        address: params[:address],
        description: params[:description],
        pet_names: @pet.name,
        status: params[:status].to_i
        })
      app_pet = ApplicationPet.new({
        application: @application,
        pet: @pet,
        pet_status: 0
        })
      app_pet.save
      redirect_to "/applications/#{@application.id}"

    elsif params[:why_i_would_make_a_good_home]
      @application = Application.find(params[:id])
      @application.update({
        description: params[:why_i_would_make_a_good_home],
        status: params[:status].to_i
        })
      redirect_to "/applications/#{@application.id}"

    end
  end
end
