require 'rails_helper'

RSpec.describe "Admin Application Show Page" do
  before :each do
    @ddfl = Shelter.create!(name: "Denver Dumb Friends League", foster_program: true, city: "Denver", rank: 5)
    @max = Shelter.create!(name: "Max Fund", foster_program: true, city: "Denver", rank: 5)
    @doggo = @ddfl.pets.create!(adoptable: true, age: 12, breed: "Cairn Terrior", name: "Sylus")
    @meow = @max.pets.create!(adoptable: true, age: 2, breed: "short hair", name: "Hopps")
    @bob = Application.create!(name: "Bob Ross", street_address: "123 Trees St.", city: "Nantuket", state: "MA", zip: "12554")
    @bill = Application.create!(name: "Bill Nye", street_address: "1265 S Main St.", city: "Los Angeles", state: "CA", zip: "90006")
    @oprah = @doggo.applications.create!(name: "Oprah", street_address: "12 Bellaire St.", city: "Los Angeles", state: "CA", zip: "90006", status: "Pending")
  end

  it 'can see a button for each pet the application is for' do
    visit "/admin/applications/#{@oprah.id}"

    expect(page).to have_content("Sylus")
    expect(page).to have_button("Approve")
  end

  it 'can click button, back to show page, see indicator that is approved' do
    visit "/admin/applications/#{@oprah.id}"

    click_button "Approve"
    expect(current_path).to eq("/admin/applications/#{@oprah.id}")
    expect(page).to_not have_button("Approve")
    expect(page).to have_content("Approved!")
  end

end
