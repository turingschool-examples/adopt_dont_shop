require 'rails_helper'

RSpec.describe 'application', type: :feature do


  describe 'Application show page' do
    before :each do
      @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
      @pet_2 = @shelter.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
      @bob = Application.create!(name: "Bob Ross", street_address: "123 Trees St.", city: "Nantuket", state: "MA", zip: "12554")
      # ApplicationPet.create!(pet: @pet_1, application: @bob)
      # @bob.pets << @pet_1
      # @bob.pets << @pet_2


    end
    it 'displays the name and location of application' do
      visit "/applications/#{@bob.id}"

      expect(page).to have_content("Bob Ross")
      expect(page).to have_content("123 Trees St. Nantuket, MA 12554")
    end

    it 'displays a description' do
      visit "/applications/#{@bob.id}"

      expect(page).to have_content("I would be a great parent because I love dogs.")
    end

    it 'displays a list of the animals applied for' do
      visit "/applications/#{@bob.id}"
      expect(page).to have_link("#{@bob.pets.name}")
      click_link "#{@bob.pets.name}"
    end

    it "displays pet search section" do
      visit "/applications/#{@bob.id}"

      fill_in :pet_select, with: "Lobster"
      click_button "submit"

      expect(page).to have_content("Lobster")
    end

    it "has a link to adopt searched pet" do
      visit "/applications/#{@bob.id}"

      expect(page).to_not have_link("Adopt this Pet")
      fill_in :pet_select, with: "Lobster"
      click_button "submit"
      expect(page).to have_link("Adopt this Pet")
      # save_and_open_page
      click_link("Adopt this Pet")
      expect(current_path).to eq("/applications/#{@bob.id}")
      expect(page).to_not have_link("Adopt this Pet")
      expect(page).to have_content("Lobster")
    end

    it "can submit an application" do
      visit "/applications/#{@bob.id}"

      fill_in :pet_select, with: "Lobster"
      click_button "submit"
      click_link("Adopt this Pet")

      fill_in :good_owner, with: "Because I love dogs."

      expect(page).to have_button("Submit This Application")
      click_button("Submit This Application")
      expect(current_path).to eq("/applications/#{@bob.id}")

      expect(page).to have_content("Pending")
      expect(page).to have_content("Lobster")
      expect(page).to_not have_content("Find Pet")
    end
  end
end
