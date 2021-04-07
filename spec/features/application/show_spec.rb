require 'rails_helper'

RSpec.describe 'applications_pets show' do
  before(:each) do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet = @shelter.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @user = User.create!(full_name: 'Mike Piz', street_address: '13214 Yeet Rd.', city: 'Cleveland', state: 'OH', zipcode: 18907)
    @application = @user.applications.create!(status: 'PENDING', description: 'Give me it')
  end

  it "shows the application and all attributes without pets" do
    visit "/applications/#{@application.id}"

    expect(page).to have_content("User: #{@user.full_name}")
    expect(page).to have_content("Street Address: #{@user.street_address}")
    expect(page).to have_content("City: #{@user.city}")
    expect(page).to have_content("State: #{@user.state}")
    expect(page).to have_content("Zipcode: #{@user.zipcode}")
    expect(page).to have_content("\nNo pets applied for\n")
  end

  it "shows the application's pets" do
    association = ApplicationsPet.create(pet_id: @pet.id, application_id: @application.id )

    visit "/applications/#{@application.id}"

    expect(page).to have_content("Applying For: #{@pet.name}")

    expect(page).to have_link(@pet.name)
    expect(page).to have_content("PENDING")
  end

  it "clicks the applied for pet and redirects to its show page" do
    assocation = ApplicationsPet.create(pet_id: @pet.id, application_id: @application.id )

    visit "/applications/#{@application.id}"

    expect(page).to have_current_path("/applications/#{@application.id}")

    expect(page).to have_link(@pet.name)
    click_link(@pet.name)
    expect(page).to have_current_path("/pets/#{@pet.id}")
  end
end
