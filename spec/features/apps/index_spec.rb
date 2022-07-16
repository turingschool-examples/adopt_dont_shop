require 'rails_helper'

RSpec.describe 'App Index' do
  it 'lists applications' do
    app_1 = App.create!(name: "Bob", address: "2020 Maple Lane", city: "Denver", state: "CO", zip: "80202", description: "ABC", status: "in progress")
    app_2 = App.create!(name: "Tom", address: "4567 Elm St", city: "Centennial", state: "CO", zip: "80209", description: "I'm bored", status: "in progress")

    visit "/apps"

    expect(page).to have_content("#{app_1.name}")
    expect(page).to have_content("#{app_2.address}")
    expect("#{app_1.description}").to appear_before("#{app_2.name}")
  end
end