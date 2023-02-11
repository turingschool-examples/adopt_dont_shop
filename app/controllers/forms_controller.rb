class FormsController < ApplicationController
  def show
    @form = Form.find(params[:id])
    
    if params[:search].present?
      @pet_search = Pet.search(params[:search])
    # else
    #   @pet_search = []
    end
  end

  def new
  end

  def create
    form = Form.new(form_params)
    if form.valid?
      form.save
      redirect_to "/forms/#{form.id}"
    else 
      flash.now[:messages] = form.errors.full_messages
      # redirect_to "/forms/#{form_params[:id]}/new"
      render :new
    end
  end

  def form_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end