class AdoptionFormsController < ApplicationController
  def show
    @pet_form = AdoptionForm.find(params[:id])
  end

  def new
  end

  def create
    new_form = AdoptionForm.create(form_params)
    redirect_to adoption_form_path(new_form)
  end

  private
  def form_params
    params.permit(:id, :first_name, :last_name, :street_address, :state, :city, :zip_code, :description)
  end
end
