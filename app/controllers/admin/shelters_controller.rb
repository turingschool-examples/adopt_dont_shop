class Admin::SheltersController < ApplicationController
  def index
    @shelters = Shelter.order_by_name_desc
  end
end
