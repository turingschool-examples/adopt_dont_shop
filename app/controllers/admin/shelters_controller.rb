module Admin
  class SheltersController < ApplicationController
    def index
      @shelters = Shelter.find_by_sql("SELECT * FROM Shelters ORDER BY Name DESC")
    end
  end
end
