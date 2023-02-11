class FormsController < ApplicationController
  def show
    @form = Form.find(params[:id])
  end

  def new
  end

  def create
    form = Form.create!(form_params)
    if form.save
      redirect_to "/forms/#{form.id}"
    else #<== this needs fixed.
      redirect_to "/forms/#{form_params[:id]}new"
      flash[:alert] = "Error: #{error_message(form.errors)}"
    end
    
  end

  def form_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end