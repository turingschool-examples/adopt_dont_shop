class Admin::ApplicationsController < ApplicationController

  def show
    # require "pry"; binding.pry
    @application = Application.find(params[:id])
    if !params[:approve].nil?
    end
  end
end
