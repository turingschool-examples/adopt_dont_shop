require 'rails_helper'

RSpec.describe 'Admin applications show page' do
  before :each do
    @application = Application.create!(name: "Bob Smith", street_address: "1234 Easy St.", city: "Denver", state: "CO", zipcode: 80001, description: 'temp description', status: "Pending")
    @shelter_1 = Shelter.create!(foster_program: true, name: "Test Shelter", city: "Denver", rank: 3)
    @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @becky = Pet.create!(adoptable: true, age: 8, breed: "Cavashon", name: "Becky", shelter: @shelter_1)
    ApplicationPet.create!(pet: @becky, application: @application)

  end
  it 'displays every pet that the application is for' do
    visit "/admin/applications/#{@application.id}"

    expect(page).to have_content("Becky")
    expect(page).to have_button("Approve #{@becky.name}")
    expect(page).to have_button("Reject #{@becky.name}")
  end

  it 'can approve a pet' do
    visit "/admin/applications/#{@application.id}"

    click_button("Approve #{@becky.name}")

    expect(current_path).to eq("/admin/applications/#{@application.id}")
    expect(page).to have_content("Approved")

    expect(page).to_not have_button("Approve #{@becky.name}")
    expect(page).to_not have_button("Reject #{@becky.name}")
  end

  it 'can reject a pet' do
    visit "/admin/applications/#{@application.id}"

    click_button("Reject #{@becky.name}")

    expect(current_path).to eq("/admin/applications/#{@application.id}")
    expect(page).to have_content("Rejected")

    expect(page).to_not have_button("Approve #{@becky.name}")
    expect(page).to_not have_button("Reject #{@becky.name}")

  end
end
