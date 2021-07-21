require 'rails_helper'

RSpec.describe 'admin shelters index page' do
  it 'displays all shelters in the system listed in reverse alphabetical order by name' do
    # Admin Shelters Index
    #
    # As a visitor
    # When I visit the admin shelter index ('/admin/shelters')
    # Then I see all Shelters in the system listed in reverse alphabetical order by name
    @shelter_3 = Shelter.create!(name: "ABC", city: "Denver, CO", rank: 2, foster_program: false)
    @shelter_2 = Shelter.create!(name: "Denver Humane Society", city: "Denver, CO", rank: 2, foster_program: false)
    @shelter_1 = Shelter.create!(name: "Boulder Humane Society", city: "Boulder, CO", rank: 1, foster_program: true)

    visit "/admin/shelters"

    expect(@shelter_2.name).to appear_before(@shelter_1.name)
    expect(@shelter_1.name).to appear_before(@shelter_3.name)
  end

  it 'displays shelters with pending applications' do
    # For this story, you should fully leverage ActiveRecord methods in your query.
    #
    # Shelters with Pending Applications
    #
    # As a visitor
    # When I visit the admin shelter index ('/admin/shelters')
    # Then I see a section for "Shelter's with Pending Applications"
    # And in this section I see the name of every shelter that has a pending application
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

    @app_1 = Application.create(name: 'Alice Pieszecki', street: '407 Race St', city: 'Denver', state: 'CO', zip_code: 80305, description: 'A reason', status: 'pending')
    @app_2 = Application.create(name: 'Bette Porter', street: '777 Corona St', city: 'Denver', state: 'CO', zip_code: 80221, description: 'B reason', status: 'pending')
    @app_3 = Application.create(name: 'Shane McCutchen', street: '1234 Pine Ave', city: 'Arvada', state: 'CO', zip_code: 80218, description: 'C reason', status: 'pending')
    @app_4 = Application.create(name: 'Jenny Schecter', street: '2043 21st St', city: 'Denver', state: 'CO', zip_code: 80218, description: 'D reason', status: 'rejected')
    @app_5 = Application.create(name: 'Tina Kennard', street: '12 Colorado Blvd', city: 'Denver', state: 'CO', zip_code: 80210, description: 'E reason', status: 'in progress')

    PetApplication.create!(application: @app_1, pet: @pet_1)
    PetApplication.create!(application: @app_2, pet: @pet_2)
    PetApplication.create!(application: @app_3, pet: @pet_3)
    PetApplication.create!(application: @app_4, pet: @pet_4)
  end
end
