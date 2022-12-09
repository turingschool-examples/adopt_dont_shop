class ApplicationsController < ApplicationController
  def new

  end

  def create
    @application = Application.create!(
      
    )
    redirect_to "applications/:id"
  end

  def show
  
  end
end
