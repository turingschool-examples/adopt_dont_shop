class AdminSheltersController < ApplicationController
  def index
    @shelters = AdminShelter.reverse_shelter
  end
end
