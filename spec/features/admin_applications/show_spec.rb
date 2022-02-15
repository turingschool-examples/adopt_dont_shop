require 'rails_helper'

RSpec.describe "Admin Applications Show Page" do
  before (:each) do
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_4 = Shelter.create!(name: 'Da best pets', city: 'Lemont, NM', foster_program: true, rank: 10)
    @application = Application.create!(name: "Chaz Carmichael",
      street_address: "10 lane",
      city: "Sandy Springs",
      state: "CO",
      zipcode: 12345)
    @application2 = Application.create!(name: "Jerg",
      street_address: "2 Blueberries",
      city: "File Drive",
      state: "CA",
      zipcode: 54321)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_4.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'dragon', name: 'Blake C', shelter_id: @shelter_1.id)
    @pet_application = PetApplication.create!(application_id: @application.id, pet_id: @pet_1.id)
    @pet_application1 = PetApplication.create!(application_id: @application.id, pet_id: @pet_2.id)
    @pet_application2 = PetApplication.create!(application_id: @application2.id, pet_id: @pet_1.id)
    @application.status = "1"
    @application.save
  end

  it "displays a button to approve application for a pet" do
    visit "/admin/applications/#{@application.id}"
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_button("Approve")
    click_on("Approve", match: :first)
    expect(current_path).to eq("/admin/applications/#{@application.id}/")
    expect(page).to have_content("This application has been approved!")
  end

  it "displays a button to reject application for a pet" do
    visit "/admin/applications/#{@application.id}"
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_button("Reject")
    click_on("Reject", match: :first)
    expect(current_path).to eq("/admin/applications/#{@application.id}/")
    expect(page).to have_content("This application has been rejected!")
  end

  it "displays a button to approve or reject application for a pet if there are two applications for the same pet" do
    visit "/admin/applications/#{@application.id}"
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_button("Reject")
    click_on("Reject", match: :first)
    expect(current_path).to eq("/admin/applications/#{@application.id}/")
    expect(page).to have_content("This application has been rejected!")
    visit "/admin/applications/#{@application2.id}"
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_button("Approve")
    expect(page).to have_button("Reject")
  end
end
