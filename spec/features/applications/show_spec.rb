require 'rails_helper'

describe "Application show page" do
  before do
    @application1 = Application.create!(name: "Paul Leonard",
                                        address: "123 Smiley St.",
                                        city: "Atlanta",
                                        state: "Georgia",
                                        zip: "31768",
                                        description: "Single guy, 3 bedroom house on 7 acres.  Lots of love to give!",
                                        status: "Pending")
    @pet1 = @application1.pets.create!(name: "Marley", age: 2)
    @pet2 = @application1.pets.create!(name: "Mack", age: 3)
    visit "/applications/#{@application1.id}"
  end

  describe 'display' do
    it "has application info" do
      expect(page).to have_content(@application1.name)
      expect(page).to have_content(@application1.address) #possible full_address method
      expect(page).to have_content(@application1.status)
      expect(page).to have_content(@application1.description)
    end

    it "has the names of all pets its applying for" do
      expect(page).to have_content(@pet1.name)
      expect(page).to have_content(@pet2.name)
    end

    it "the names of pets are links to their show page" do
      click_link "#{@pet1.name}"

      expect(current_page).to eq("/pets/#{@pet1.id}")
    end
  end
end
