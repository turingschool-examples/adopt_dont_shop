class Admin::ApplicationsController < ApplicationController
   def show
      @application = Application.find(params[:id])
      @pets = @application.pets

      if params.include?(:search)
         @adopted_pets = Pet.search(params[:search])
      end
   end
end