class ApplicationPetsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @app_pets = ApplicationPet.where("application_id = #{@application.id}")
    # @app_pets = ApplicationPet.find_by_sql(Select * FROM applicationpets where application)
  end
end