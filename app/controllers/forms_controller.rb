class FormsController < ApplicationController
  def show
    @form = Form.find(params[:id])
  end

  def new
  end

  def create
    # require 'pry'; binding.pry
    form = Form.create!(form_params)
    redirect_to "/forms/#{form.id}"
  end

  def form_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end