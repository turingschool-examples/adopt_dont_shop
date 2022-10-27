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

    within("#pet-#{@becky.id}") do
      expect(page).to have_content(@becky.name)
      expect(page).to have_button("Approve #{@becky.name}")
      expect(page).to have_button("Reject #{@becky.name}")
    end
  end

  it 'can approve a pet' do
    visit "/admin/applications/#{@application.id}"

    within("#pet-#{@becky.id}") do
      click_button("Approve #{@becky.name}")
      expect(current_path).to eq("/admin/applications/#{@application.id}")
      expect(page).to have_content("Approved")
      expect(page).to_not have_button("Approve #{@becky.name}")
      expect(page).to_not have_button("Reject #{@becky.name}")
    end
  end

  it 'can reject a pet' do
    visit "/admin/applications/#{@application.id}"

    within("#pet-#{@becky.id}") do
      click_button("Reject #{@becky.name}")
      expect(current_path).to eq("/admin/applications/#{@application.id}")
      expect(page).to have_content("Rejected")
      expect(page).to_not have_button("Approve #{@becky.name}")
      expect(page).to_not have_button("Reject #{@becky.name}")
    end
  end

  it "can approve or reject the same pet on multiple applications" do
    application_2 = Application.create!(name: "John Smith", street_address: "1434 Hard St.", city: "Denver", state: "CO", zipcode: 80101, description: 'temp description', status: "Pending")
    ApplicationPet.create!(pet: @becky, application: application_2)

    visit "/admin/applications/#{@application.id}"
    click_button("Approve #{@becky.name}")
    visit "/admin/applications/#{application_2.id}"
    expect(page).to have_content("Becky")
    expect(page).to have_button("Approve #{@becky.name}")
    expect(page).to have_button("Reject #{@becky.name}")

    visit "/admin/applications/#{@application.id}"
    expect(page).to have_content("Approved")
  end

  it "can approve the overall application when all pets are approved" do
    bean = Pet.create!(adoptable: true, age: 3, breed: "Bulldog", name: "Bean", shelter: @shelter_3)
    ApplicationPet.create!(pet: bean, application: @application)

    visit "/admin/applications/#{@application.id}"

    click_button("Approve #{@becky.name}")
    # require "pry"; binding.pry
    click_button("Approve #{bean.name}")
    # require "pry"; binding.pry
    expect(page).to have_content("Your application has been approved!")
    # require "pry"; binding.pry
    # expect(@application.status).to eq("Approved")
    expect(@application.reload.status).to eq("Approved")
  end
end
