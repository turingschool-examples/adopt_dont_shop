class ApplicationsController < ActionController::Base
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
  end

end
