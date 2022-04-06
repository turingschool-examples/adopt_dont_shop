require "rails_helper"

RSpec.describe "admin shelter index" do
  before do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @application1 = Application.create(
      name: 'The Original Sherman',
      address: '123 Main St', city: 'Longmont', state: 'CO', zipcode: '80501',
      description: '  ', status: "Pending"
      )
    @application2 = Application.create(
      name: 'Sherman1',
      address: '123 Main St', city: 'Longmont', state: 'CO', zipcode: '80501',
      description: '   ', status: "Pending"
      )
    @application3 = Application.create(
      name: 'Sherman2',
      address: '123 Main St', city: 'Longmont', state: 'CO', zipcode: '80501',
      description: ' '
      )
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)
    @pet_5 = @shelter_2.pets.create(name: 'Clawdias', breed: 'shorthair', age: 3, adoptable: true)

    PetApplication.create!(pet_id: @pet_1.id, application_id: @application1.id)
    PetApplication.create!(pet_id: @pet_5.id, application_id: @application2.id)

    visit "/admin/shelters"
    @shelters = [@shelter_1, @shelter_2, @shelter_3]
  end

  it 'can return all shelters in reverse alpha order' do
    @shelters.each do |shelter|
    expect(page).to have_content(shelter.name)
    end
    expect(@shelter_2.name).to appear_before(@shelter_1.name)
    expect(@shelter_1.name).to_not appear_before(@shelter_3.name)
  end

  it 'has a section that shows all shelters with pending applications' do
    save_and_open_page
    within '.pending' do
      expect(page).to have_content(@shelter_1.name)
      expect(page).to have_content(@shelter_2.name)
      expect(page).to_not have_content(@shelter_3.name)
    end
  end

end
