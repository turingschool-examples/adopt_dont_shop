class ApplicationsController < ApplicationController

   def show
     @application = Application.find(params[:application_id])
     # require "pry"; binding.pry
     if params[:search]
      @pets = Pet.search(params[:search])
      end
   end

   def new
   end

   def create
     application = Application.create(application_params)
     if application.save
       redirect_to "/applications/#{application.id}"
     else
       flash[:notice] = "Application not created: Required information missing."
       redirect_to "/applications/new"
     end
   end

   def update
     application = Application.find(params[:id])
     application.update({message: params[:message], status: "Pending"})

     application.save
     redirect_to "/applications/#{application.id}"
   end


private
  def application_params
    params
    .permit(:name, :street, :city, :state, :zip, )
    .with_defaults(status:"In Progress", message: "")
  end
end
