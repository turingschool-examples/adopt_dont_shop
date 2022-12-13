class Admin::PetApplicationsController < ApplicationController
  def update
    pa = PetApplication.where(pa_params).first
    pa.update(update_params)
    redirect_to "/admin/applications/#{pa.application_id}"
  end
  
  private
  
  def pa_params
    { pet_id: params[:pet_id], application_id: params[:id] }
  end
  
  def update_params
    { status: params[:approve] }
  end
end

