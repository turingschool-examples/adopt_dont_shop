class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:application_id])
  end
end