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
end
