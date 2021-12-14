require 'rails_helper'

RSpec.describe 'the application show page' do
  before(:each) do
    @application_1 = Application.create!(name: "Robin Dittrich", address: "111 Get Stoked Ave", city: "Bellingham", state: "WA", zip:"98225", description:"Mid sized home with two other dogs that need another friend", status: "pending")
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_1.id)
    @pet_2 = @shelter_1.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_1.id)
    @pet_application_1 = @application_1.pet_applications.create!(pet_id: @pet_1.id)
    @pet_application_1 = @application_1.pet_applications.create!(pet_id: @pet_2.id)
  end

  describe 'display' do
    it "shows the info of the applicant" do
      visit "/applications/#{@application_1.id}"

      expect(page).to have_content(@application_1.name)
      expect(page).to have_content(@application_1.address)
      expect(page).to have_content(@application_1.city)
      expect(page).to have_content(@application_1.state)
      expect(page).to have_content(@application_1.zip)
      expect(page).to have_content(@application_1.description)
      expect(page).to have_content(@application_1.status)
    end

    it 'includes the names of all the pets that the application is for with links to show page' do
      visit "/applications/#{@application_1.id}"

      click_link "#{@pet_1.name}"

      expect(page).to have_current_path("/pets/#{@pet_1.id}")

      visit "/applications/#{@application_1.id}"
      click_link "#{@pet_2.name}"

      expect(page).to have_current_path("/pets/#{@pet_2.id}")
    end
  end
end
