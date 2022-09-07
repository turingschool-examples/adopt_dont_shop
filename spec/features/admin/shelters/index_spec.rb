require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I visit the admin shelter index' do

    before :each do
      @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    end

    it "Then I see all Shelters in the system listed in reverse alphabetical order by name" do
      visit '/admin/shelters'

      expect("RGV").to appear_before("Fancy")
      expect("Fancy").to appear_before("Aurora")
    end

    describe "Then I see a section for Shelters with Pending Applications" do
      it "in this section I see the name of every shelter that has a pending application" do
        @pirate = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
        @clawdia = @shelter_3.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
        @lucille = @shelter_2.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
            #RGV has no pets currently
        @billy = Applicant.create!(first_name: "Billy",
                                  last_name: "Jameson",
                                  street_address: '123 Royal Lane',
                                  city: "Denver",
                                  state: "CO",
                                  zipcode: 80205,
                                  status: "Pending")

        @johnny = Applicant.create!(first_name: "Johnny",
                                  last_name: "Maybach",
                                  street_address: '456 Froot Loop Way',
                                  city: "Mattoon",
                                  state: "IL",
                                  zipcode: 54242,
                                  status: "Pending")

        @jimmy = Applicant.create!(first_name: "Jimmy",
                                  last_name: "Long",
                                  street_address: '123 George street',
                                  city: "californian",
                                  state: "CA",
                                  zipcode: 90210,
                                  status: "In Progress")
        @aurora = @shelter1
        @rgv = @shelter2
        @fancy = @shelter3

        PetApplication.create!(pet: @pirate, applicant: @billy)
        PetApplication.create!(pet: @clawdia, applicant: @johnny)
        PetApplication.create!(pet: @lucille, applicant: @jimmy)


        visit '/admin/shelters'

        expect(page).to have_content("Pending Applications")
        #use within here
        expect(page).to have_content("#{@aurora.name}")
        expect(page).to have_content("#{@fancy.name}")
        expect(page).not_to have_content("#{@rgv.name}")
      end
    end
  end
end
# For this story, you should fully leverage ActiveRecord methods in your query.
#
# As a visitor
# When I visit the admin shelter index ('/admin/shelters')
# Then I see a section for "Shelter's with Pending Applications"
# And in this section I see the name of every shelter that has a pending application
