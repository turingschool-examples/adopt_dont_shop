require "rails_helper"

RSpec.describe "the Request show page" do 
  describe "as a visitor" do 
    describe "when I visit the Request show page" do 
      it "displays the application attributes" do 
        Application.create!()
        visit "/requests/"
      end
    end
  end

end