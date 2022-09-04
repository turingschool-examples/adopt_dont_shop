require 'rails_helper'

RSpec.describe "Application Index" do
  before :each do
    @shelter = Shelter.create!(name: "Craig's Raccoon Emporium", rank: 1, city: "Omaha")

    @beldof = @shelter.apps.create!(
      name: "Gob Beldof", 
      address: "152 Animal Ave.", 
      city: "Omaha, NE",
      zip_code: "19593",
      description: "We love raccoons and would like more please. They will live a good life and will not have to eat carrots. Ever.",
      status: "In Progress"
    )
    @garbo = @shelter.apps.create!(
      name: "Gary Garbo", 
      address: "12 Number Way", 
      city: "Omaha, NE", 
      zip_code: "19593",
      description: "Give us dem trash bears",
      status: "In Progress"
    )
    visit "/apps"
  end

  it 'displays all apps with links to their show page' do
    expect(page).to have_link("Gob Beldof")
    expect(page).to have_link("Gary Garbo")
  end

  
end