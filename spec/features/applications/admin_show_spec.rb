require 'rails_helper'

RSpec.describe 'admin application show page' do
  before(:each) do
    @application = Application.create!(
      name: "Joel Grant",
      street_address: "1234 Grant Road",
      city: "Littleton",
      state: "Colorado",
      zip: "80120"
      # description: "I love dogs"
    )
    @shelter = Shelter.create!(name: "Love Dogs Shelter", city: "Denver", rank: 10, foster_program: true)
    @pet_1 = @shelter.pets.create!(name: "Buster", adoptable: true, age: 2, breed: "Black Lab")
    @pet_2 = @shelter.pets.create!(name: "Minnie", adoptable: true, age: 2, breed: "Chow")
    @pet_3 = @shelter.pets.create!(name: "Busted", adoptable: true, age: 6, breed: "Bulldog")
    ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application.id)
    ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application.id)
  end

  describe 'when I visit the admin applications show page' do
    it 'shows each pet in the application with a button to approve the application' do
      visit "/admin/applications/#{@application.id}"

      click_button "Approve #{@application.pets[0].name}"

      expect(current_path).to eq("/admin/applications/#{@application.id}")
      expect(page).to have_content("#{@application.pets[0].name}")
      expect(page).to_not have_button("Approve #{@application.pets[0].name}")
      expect(page).to have_content("#{@application.pets[0].name} Approved")
    end
  end
end
