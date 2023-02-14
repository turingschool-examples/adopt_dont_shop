require 'rails_helper'

RSpec.describe "The Admin Shelter Index" do
  describe "User Story 10" do
    it " Displays to the user all shelters in the system listed in reverse alphabetical order " do
      shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      shelter_2 = Shelter.create!(name: 'Denver shelter', city: 'Denver, CO', foster_program: false, rank: 8)
      shelter_3 = Shelter.create!(name: 'Vail shelter', city: 'Vail, CO', foster_program: false, rank: 7)

      visit "/admin/shelters"

      expect("#{shelter_2.name}").to appear_before("#{shelter_1.name}")
    end
  end
end