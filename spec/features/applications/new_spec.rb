require 'rails_helper'

RSpec.describe "new application page" do

  it "creates a new application" do
    visit '/applications/new'

    fill_in("Name", with: "Jenn")
    fill_in("Street address", with: "2 Wildflower Lane")
    fill_in("City", with: "Aurora")
    fill_in("State", with: "CO")
    fill_in("Zip code", with: 80010)
    fill_in("Description", with: "I need fluffy pets to cuddle")

    click_on("Submit")
    application = Application.last
    expect(current_path).to eq("/applications/#{application.id}")
  end
end
