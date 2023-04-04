require 'rails_helper'

RSpec. describe "Admin Shelter show page", type: :feature do
  describe "displayed information" do
    before do
      @shelter_1 = Shelter.create!(foster_program: true, name: "Taj Mahal for Dogs", city: "Sky City", rank: 20, street_address: "123 road street", state: "WA", zipcode: "55555")
      @shelter_2 = Shelter.create!(foster_program: true, name: "Valhalla for Cats", city: "Literally the Moon", rank: 30, street_address: "345 street avenue", state: "CO", zipcode: "44444")
      @shelter_3 = Shelter.create!(foster_program: true, name: "Alexandria for Squirrels", city: "Death City", rank: 40, street_address: "567 avenue road", state: "NV", zipcode: "33333")
      @shelter_4 = Shelter.create!(foster_program: true, name: "Shangri La for Turtles", city: "Seattle", rank: 50, street_address: "789 avenue road", state: "HI", zipcode: "22222")
      @pet_1 = @shelter_1.pets.create!(name: "Foster", age: 1000, breed: "dog")
      @pet_2 = @shelter_2.pets.create!(name: "Bento", age: 23, breed: "dog")
      @pet_3 = @shelter_3.pets.create!(name: "Quiggle", age: 555,)
      @pet_4 = @shelter_4.pets.create!(name: "Simpleton", age: 80,)
      @pet_5 = @shelter_1.pets.create!(name: "Snapchat", age: 799,)
      @application_1 = Application.create!(applicant_name: "Bob", street_address: "123 Home St", city: "Denver", state: "CO", zip_code: "80238", description: "I love animals")
      @application_2 = Application.create!(applicant_name: "Nebula", street_address: "45 Hippy Avenue", city: "Portland", state: "OR", zip_code: "40009", description: "Animals deserve to be freed into the woods")
      @application_3 = Application.create!(applicant_name: "Angry Tim", street_address: "94 Gun Street", city: "Dallas", state: "TX", zip_code: "60888", description: "Don't question me or my motives")
      PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
      PetApplication.create!(pet_id: @pet_3.id, application_id: @application_1.id)
      PetApplication.create!(pet_id: @pet_5.id, application_id: @application_1.id)
      PetApplication.create!(pet_id: @pet_2.id, application_id: @application_2.id)
      PetApplication.create!(pet_id: @pet_4.id, application_id: @application_2.id)
      PetApplication.create!(pet_id: @pet_4.id, application_id: @application_3.id)
      PetApplication.create!(pet_id: @pet_5.id, application_id: @application_3.id)
    end

    it "shows the correct info" do
      visit "/admin/shelters/#{@shelter_2.id}"
      expect(page).to have_content("Valhalla for Cats")
      expect(page).to have_content("345 street avenue Literally the Moon CO 44444")

      visit "/admin/shelters/#{@shelter_4.id}"
      expect(page).to have_content("Shangri La for Turtles")
      expect(page).to have_content("789 avenue road Seattle HI 22222")
    end

    it "Average adoptable pet age" do
      pet_6 = @shelter_3.pets.create!(name: "Rockabilly", age: 200)
      pet_7 = @shelter_1.pets.create!(name: "Malaria", age: 12)
      pet_app_1 = PetApplication.create!(pet_id: pet_6.id, application_id: @application_3.id)
      pet_app_2 = PetApplication.create!(pet_id: pet_7.id, application_id: @application_3.id)

      visit "/admin/shelters/#{@shelter_3.id}"
      
      within('#statistics'){expect(page).to have_content("Average Pet Age: 377.5")}

      visit "/admin/shelters/#{@shelter_1.id}"

      within('#statistics'){expect(page).to have_content("Average Pet Age: 603.67")}

      visit "/admin/applications/#{@application_3.id}"
      click_link "Approve #{@pet_4.id}"
      click_link "Approve #{@pet_5.id}"
      click_link "Approve #{pet_6.id}"
      click_link "Approve #{pet_7.id}"
      @application_3.update_status

      visit "/admin/shelters/#{@shelter_1.id}"
      
      within('#statistics'){expect(page).to have_content("Average Pet Age: 1000")}
    end

    it "shows number of adoptable pets in statistics section" do
      pet_6 = @shelter_3.pets.create!(name: "Rockabilly", age: 200)
      pet_7 = @shelter_1.pets.create!(name: "Malaria", age: 12)
      pet_app_1 = PetApplication.create!(pet_id: pet_6.id, application_id: @application_3.id)
      pet_app_2 = PetApplication.create!(pet_id: pet_7.id, application_id: @application_3.id)

      visit "/admin/shelters/#{@shelter_3.id}"
      
      within('#statistics'){expect(page).to have_content("Adoptable Pets: 2")}

      visit "/admin/shelters/#{@shelter_1.id}"

      within('#statistics'){expect(page).to have_content("Adoptable Pets: 3")}

      visit "/admin/applications/#{@application_3.id}"
      click_link "Approve #{@pet_4.id}"
      click_link "Approve #{@pet_5.id}"
      click_link "Approve #{pet_6.id}"
      click_link "Approve #{pet_7.id}"
      @application_3.update_status

      visit "/admin/shelters/#{@shelter_1.id}"
      
      within('#statistics'){expect(page).to have_content("Adoptable Pets: 1")}
    end
  end
end