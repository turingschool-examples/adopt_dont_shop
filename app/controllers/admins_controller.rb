class AdminsController < ActionController::Base

  def shelters_index
    @shelters = Shelter.order_by_reverse_alphabetical
  end

  def application_show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def application_approve_reject_button
    @application = Application.find(params[:application_id])
    @pet_application = PetApplication.find_by(pet_id: params[:pet_id], application_id: @application.id)
    if params[:button] == 'approve'
      @pet_application.status = "Approved"
      @pet_application.save
    elsif params[:button] == 'reject'
      @pet_application.status = "Rejected"
      @pet_application.save
    end
    redirect_to "/admin/applications/#{@application.id}"
  end
end
