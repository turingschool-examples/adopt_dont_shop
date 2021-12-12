class Admin::SheltersController < ApplicationController
  def index
    @shelters = Admin::Shelter.all.admin_display
  end
end
