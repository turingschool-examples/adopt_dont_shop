class ApplicationsController < ActionController::Base
    def index
        @applications = Application.all
    end
end
