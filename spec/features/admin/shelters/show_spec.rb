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

     it 'there is a section for stats where you see average age of all adoptable pets for that shelter' do 
        mystery = Shelter.create!(name: 'Mystery Building', address: "323 Main St", city: 'Irvine, CA', zip: 76543, foster_program: false, rank: 9)
        lucille = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: mystery.id)
        lobster = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: mystery.id)
        beethoven = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: mystery.id) 
        barey = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: mystery.id)
       
        visit "/admin/shelters/#{mystery.id}"        

        expect(page).to have_content("#{mystery.name} Statistics")
        expect(page).to have_content("Average pet age: 3.67")
    end 

    it 'in the stats section, I see the number of adoptable pets' do 
        mystery = Shelter.create!(name: 'Mystery Building', address: "323 Main St", city: 'Irvine, CA', zip: 76543, foster_program: false, rank: 9)
        lucille = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: mystery.id)
        lobster = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: mystery.id)
        beethoven = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: mystery.id) 
        barey = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: mystery.id)
       
        visit "/admin/shelters/#{mystery.id}"    

        expect(page).to have_content("Adoptable pets: 3")
    end 
end 