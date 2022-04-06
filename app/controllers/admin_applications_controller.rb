class AdminApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @app_pets = @application.application_pets
    @pets = @application.pets
    # require "pry"; binding.pry
  end

  def update

    if params[:approve]
      @application = Application.find(params[:id])
      id = params[:pet_id].to_i

      @app_pet = @application.application_pets.where(pet_id: id)
      @app_pet.update(pet_status: 1)
      if @application.all_pets_approved? == false
        @application.update({status: 3})
        @application.save
      else @application.all_pets_approved? == true
        @application.update({status: 2})
        @application.save
        pets_now_unadoptable
      end
      redirect_to "/admin/applications/#{@application.id}"

    elsif params[:deny]
      @application = Application.find(params[:id])
      id = params[:pet_id].to_i

      @app_pet = @application.application_pets.where(pet_id: id)
      @app_pet.update(pet_status: 2)

      redirect_to "/admin/applications/#{@application.id}"

    end
  end

  private
    def pets_now_unadoptable
      if @application.all_pets_approved? == true
        @application.pets.each do |pet|
        pet.update({adoptable:false})
          pet.save
        end
      end
    end

    def message_for_unadoptable_pets

    end


end
