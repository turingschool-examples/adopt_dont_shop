module Admin
  class SheltersController < ApplicationController

    def index
      @shelters = Shelter.order_alpha_desc
      @shelters_pending_apps = Shelter.pending_applications
    end

  end
end
