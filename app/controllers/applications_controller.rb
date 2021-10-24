class ApplicationsController < ActionController::Base
  
  def new  
    @application = Application.new
  end

  def create
    application = Application.create({
      name: params[:name],
      street_address: params[:street],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      reason: params[:reason],
      status: "In Progress",
      created_at: DateTime.now,
      updated_at: DateTime.now
    })    

    application.save

    redirect_to "/applications/#{application.id}"
  end

  def show 
    @application = Application.find(params[:id])
  end 


end 