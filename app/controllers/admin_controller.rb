class AdminController < ApplicationController
  def shelters_index
    @shelters = Shelter.order_alpha
    @shelters_pending = Shelter.join_application_pending
  end

  def applications_show
    @application = Application.find(params[:id])
    @pets = Pet.filter_by_name(params,@application)
    @applicationpets = ApplicationPet.findall(@application.pets,@application)
  end

  def applications_update
    @application = Application.find(params[:id])
    @pet = Pet.find(params[:pet_id])
    @applicationpet = ApplicationPet.find_application(@pet,@application)
    if params['commit'] == "Approve #{@pet.name}"
    @applicationpet.first.update({
      approved: true,
    })
    end
    if params['commit'] == "Reject #{@pet.name}"
      @applicationpet.first.update({
        approved: false,
      })
    end
    redirect_to "/admin/applications/#{@application.id}"

  end

end