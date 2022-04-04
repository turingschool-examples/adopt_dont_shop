class Application_Pets_Controller < ApplicationController

  def new
    @application_pet = ApplicationPet.new
  end

  def create
    application_pet = ApplicationPet.create(app_params)
  end
end


private

  def app_params

  end
