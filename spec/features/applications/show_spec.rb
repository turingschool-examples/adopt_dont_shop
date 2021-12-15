require 'rails_helper'

describe "Application show page" do
  before do
    @application1 = Application.create!(name: "Paul Leonard",
                                        address: "123 Smiley St.",
                                        city: "Atlanta",
                                        state: "Georgia",
                                        zip: "31768",
                                        description: "Single guy, 3 bedroom house on 7 acres. Lots of love to give!",
                                        status: "Pending")
    @shelter1 = Shelter.create!(name: "Humane Society", rank: 8, city: "Atlanta")
    @pet1     = @shelter1.pets.create!(name: "Marley", age: 2, shelter_id: @shelter1.id)
    @pet2     = @shelter1.pets.create!(name: "Mack", age: 3, shelter_id: @shelter1.id)
    visit "/applications/#{@application1.id}"
  end

  describe 'display' do
    it "has application info" do
      expect(page).to have_content(@application1.name)
      expect(page).to have_content(@application1.address) #possible full_address method
      expect(page).to have_content(@application1.city)
      expect(page).to have_content(@application1.state)
      expect(page).to have_content(@application1.zip)
      expect(page).to have_content(@application1.description)
      expect(page).to have_content(@application1.status)
    end

    it "has the names of all pets its applying for" do
      pet_application1 = @application1.pet_applications.create!(pet_id: @pet1.id)
      pet_application2 = @application1.pet_applications.create!(pet_id: @pet2.id)

      expect(page).to have_content(@pet1.name)
      expect(page).to have_content(@pet2.name)
    end

    it "the names of pets are links to their show page" do
      pet_application1 = @application1.pet_applications.create!(pet_id: @pet1.id)
      pet_application2 = @application1.pet_applications.create!(pet_id: @pet2.id)
      
      click_link "#{@pet1.name}"

      expect(current_path).to eq("/pets/#{@pet1.id}")
    end

    it "has a section where you can add pets to the application" do
      expect(page).to have_content("Add a Pet to this Application")
      fill_in("Search", with: "#{@pet2.name}")

      click_button('Submit')

      expect(current_path).to eq("/applications/#{@application1.id}")
    end

    it "adds pets to the application if it is found in search" do
      fill_in("Search", with: "#{@pet2.name}")

      click_button('Submit')
      expect(page).to have_content(@pet2.name)
      expect(page).to_not have_content(@pet1.name)
    end


    it 'if the pet is not found it will flash a fail message' do
      visit "/applications/#{@application1.id}"

      click_button('Submit')
      expect(page).to have_content("No results found. Please try again.")
    end
  end
end
