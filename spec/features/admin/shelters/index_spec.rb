require 'rails_helper'

RSpec.describe 'the admin/shelters page' do

  #   SQL Only Story
  #
  # For this story, you should write your queries in raw sql. You can use the ActiveRecord find_by_sql method to execute raw sql queries: https://guides.rubyonrails.org/active_record_querying.html#finding-by-sql
  #
  # Admin Shelters Index
  #
  # As a visitor
  # When I visit the admin shelter index ('/admin/shelters')
  # Then I see all Shelters in the system listed in reverse alphabetical order by name


  it "shows the Shelters in reverse alphabetical order" do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    shelters = Shelter.all
    visit "/admin/shelters"
    # save_and_open_page
    expect(shelters.count).to eq(3)
    expect(Shelter.names_sorted.first.name).to eq('RGV animal shelter')
    expect(Shelter.names_sorted.last.name).to eq('Aurora shelter')
  end

  #   For this story, you should fully leverage ActiveRecord methods in your query.
  #
  # Shelters with Pending Applications
  #
  # As a visitor
  # When I visit the admin shelter index ('/admin/shelters')
  # Then I see a section for "Shelter's with Pending Applications"
  # And in this section I see the name of every shelter that has a pending application

  it "shows the Shelters with pending applications" do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_1.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_2.id)
    pet_3 = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: @shelter_3.id)

    application_one = Application.create!(name: 'Sally Smith', address: '123 West 23rd Ave', city: 'Parker', state: 'CO', zip: '80134')

    visit "/applications/#{application_one.id}"
    fill_in( "pet_of_interst_name", with: "Lucille Bald")
    click_on("Find")
    click_on("Adopt Lucille Bald")
    fill_in( "description", with: "I would love a new friend.")
    click_on("Submit Adoption Form")
    pending_applications = Application.pending
    visit "/admin/shelters"

    expect(Application.all.count).to eq(1)
    expect(Application.first.status).to eq("Pending")
    expect(Application.pending.first).to eq(application_one)
    expect(Application.pending.first.shelter_id).to eq(@shelter_1.id)
  end

end
