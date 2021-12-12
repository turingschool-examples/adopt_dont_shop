require 'rails_helper'

describe 'Admin Shelter Index' do
  before do
    @shelter1 = Shelter.create(name: 'Rescue Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
    @shelter2 = Shelter.create(name: 'Animal Shelter', city: 'Denver, CO', foster_program: true, rank: 6)
    @shelter3 = Shelter.create(name: 'Humane Shelter', city: 'Denver, CO', foster_program: false, rank: 9)
    @application1 = Application.create(name: 'Devin', address: '123 Easy St', state: "Colorado", city: "Denver", zip: "80911", description: "I like degs", status: "Pending")
    @application2 = Application.create(name: 'Devin', address: '123 Easy St', state: "Colorado", city: "Denver", zip: "80911", description: "I like degs", status: "Pending")
    @application3 = Application.create(name: 'Devin', address: '123 Easy St', state: "Colorado", city: "Denver", zip: "80911", description: "I like degs", status: "Pending")
    @application1.pets.create!(adoptable: true, age: 4, breed: 'doberman', name: 'Carson', shelter_id: @shelter1.id)
    @application3.pets.create!(adoptable: true, age: 6, breed: 'heeler' , name: 'Larry', shelter_id: @shelter3.id)
    visit '/admin/shelters'
  end

  describe 'display' do
    it 'in section of shelters with pending applications, shelters are alphabetical' do
      expect(@shelter2.name).to appear_before(@shelter3.name)
      expect(@shelter3.name).to appear_before(@shelter1.name)

      within('#Shelters_pending') do
        expect(page).to have_content("Shelter's with Pending Applications")
        expect(page).to_not have_content(@shelter2.name)
        # expect(@shelter3.name).to appear_before(@shelter1.name)
      end
    end
  end
end