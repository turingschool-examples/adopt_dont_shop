class AdoptionFormsController < ApplicationController
  def show
    @pet_form = AdoptionForm.find(params[:id])
  end

  def new
  end

  def create
    new_form = AdoptionForm.new(form_params)

    if new_form.save
      redirect_to adoption_form_path(new_form)
    else
      redirect_to new_adoption_form_path
      flash[:alert] = "Error: #{error_message(new_form.errors)}"
    end
  end

  private
  def form_params
    params.permit(:id, :first_name, :last_name, :street_address, :state, :city, :zip_code, :description)
  end
end
