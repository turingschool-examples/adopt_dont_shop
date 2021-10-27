class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    application = Application.find(params[:id])

    if params[:pet_id]
      petapp = application.find_pet_application(params[:pet_id])
    end

    if params[:commit] == 'Approve'
      petapp.update(approved: true)

      if application.all_pets_approved?
        application.update(status: 'Approved')
        application.pets.update(adoptable: false)
      end

    elsif params[:commit] == 'Reject'
      petapp.update(approved: false)
      application.update(status: 'Rejected')
    end

    redirect_to "/admin/applications/#{application.id}"
  end
end
