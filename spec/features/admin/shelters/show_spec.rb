require 'rails_helper'

RSpec.describe 'admin shelter show page' do 
    it 'has a show page where the shelters name and full address are present' do 
        mystery = Shelter.create!(name: 'Mystery Building', address: "323 Main St", city: 'Irvine, CA', zip: 76543, foster_program: false, rank: 9)
        aurora = Shelter.create!(name: 'Aurora shelter', address: "10000 High Ct. # 5", city: 'Aurora, CO', zip: 80987, foster_program: false, rank: 9)

        visit "/admin/shelters/#{mystery.id}"

        expect(page).to have_content(mystery.name)
        expect(page).to have_content(mystery.address)
        expect(page).to have_content(mystery.city)
        expect(page).to have_content(mystery.zip)
    end 
end 