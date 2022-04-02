require "rails_helper"

RSpec.describe 'admin_shelters index page' do
  describe 'as a visitor' do
    describe 'when i visit the admin_shelters index' do
      it 'i see all shelters in the system listed in reverse alphabetical order' do
        shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
        shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

        visit "/admin/shelters"

        expect(shelter_2).to appear_before(shelter_3)
        expect(shelter_3).to appear_before(shelter_1)
      end
    end
  end
end
