class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    application = Application.find(params[:id])

    if params[:pet_id]
      petapp = application.find_pet_application(params[:pet_id])
    end

    if petapp && params[:commit] == 'Approve'
      petapp.update(approved: true)
      # check applications method to see if all pets are approved (move this approval check to model)
      if application.pet_applications.where(approved: false || nil).count == 0
        application.update(status: 'Approved')
      end
    elsif petapp && params[:commit] == 'Reject'
      petapp.update(approved: false)
      application.update(status: 'Rejected')
    end

    redirect_to "/admin/applications/#{application.id}"
  end
end
