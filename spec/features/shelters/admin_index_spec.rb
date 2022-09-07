require 'rails_helper'

RSpec.describe 'the admin_shelters index' do
  before :each do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @applicant_1 = Applicant.create!(first_name: 'Jimmy', last_name: 'Dough', street_address: '567 Fake Street', city: 'Denver',
      state: 'CO', zip: 80205, description: "I'm awesome", status: 'Pending')
    @applicant_2 = Applicant.create!(first_name: 'Johnny', last_name: 'Johnson', street_address: '17 Psuedo Street', city: 'Denver',
      state: 'CO', zip: 80205, description: "I'm awesome", status: 'In Progress')
    @applicant_3= Applicant.create!(first_name: 'Timmy', last_name: 'Thompson', street_address: '57 Real Street', city: 'Denver',
      state: 'CO', zip: 80207, description: "I'm not so awesome", status: 'Pending')
    @applicant_4= Applicant.create!(first_name: 'Tommy', last_name: 'Timson', street_address: '12227 Real Blvd', city: 'Colorado Springs',
      state: 'CO', zip: 80909, description: "I'm the worst", status: 'Approved')
    @pet_1 = @applicant_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false, shelter_id: @shelter_1.id)
    @pet_2 = @applicant_2.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true, shelter_id: @shelter_2.id)
    @pet_3 = @applicant_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true, shelter_id: @shelter_3.id)
    @pet_4 = @applicant_1.pets.create!(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true, shelter_id: @shelter_1.id)
  end

  describe 'admin/shelters info' do
    it "shows all shelters in the system in desc order" do

      visit '/admin/shelters'

      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_2.name).to appear_before(@shelter_1.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
      expect(@shelter_1.name).to_not appear_before(@shelter_3.name)
      expect(@shelter_3.name).to_not appear_before(@shelter_2.name)
      expect(@shelter_1.name).to_not appear_before(@shelter_3.name)
    end

    it 'I see a section for Shelters with Pending Applications' do

      visit '/admin/shelters'

      expect(page).to have_content("Shelters with Pending Applications")
    end


    it 'I see the name of every shelter that has a pending application' do

      visit '/admin/shelters'

      within("#pending-shelters") do
        expect(page).to have_content(@shelter_1.name)
        expect(page).to have_content(@shelter_3.name)
        expect(page).to_not have_content(@shelter_2.name)
      end
    end
  end
end
