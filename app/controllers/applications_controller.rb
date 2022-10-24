class ApplicationsController < ApplicationController 
  def show 
    @application = Application.find(params[:id])
    @pets = []
    show_page_logic
    application_submission
  end

  def show_page_logic
    if params[:search].present?
      @pets = Pet.search(params[:search])
    elsif params[:pet_id].present?
      @application.pets << Pet.find(params[:pet_id])
    end
  end

  def application_submission_show_up
    @display = false
    if @application.pets.length > 0
      @display = true
    end
  end

  def application_submission
    application_submission_show_up
    if params[:reason].present?
      @application.update(:status => params[:status], :reason => params[:reason])
      @application.save
    end
  end

  def new  
  end

  def create 
    application = Application.new(application_params)
    application.save
    if application.invalid? 
      redirect_to "/applications/new", alert: "Please fill missing fields"
    else
      redirect_to "/applications/#{application.id}"
    end
  end
private 
  def application_params 
    params.permit(:applicant, :street, :city, :state, :zipcode, :reason, :status)
  end
end