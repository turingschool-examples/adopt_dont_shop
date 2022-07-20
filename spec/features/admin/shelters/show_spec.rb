require 'rails_helper'

RSpec.describe 'admin shelter show page' do 
    it 'has a show page where the shelters name and full address are present' do 
        mystery = Shelter.create!(name: 'Mystery Building', address: "323 Main St", city: 'Irvine, CA', zip: 76543, foster_program: false, rank: 9)
        aurora = Shelter.create!(name: 'Aurora shelter', address: "10000 High Ct. # 5", city: 'Aurora, CO', zip: 80987, foster_program: false, rank: 9)

        visit "/admin/shelters/#{mystery.id}"

        expect(page).to have_content('Mystery Building')
        expect(page).to have_content(mystery.address)
        expect(page).to have_content(mystery.city)
        expect(page).to have_content(mystery.zip)
        expect(page).to_not have_content(aurora.name)
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

    it 'in the stats section, I see the number of pets that have been adopted' do 
        mystery = Shelter.create!(name: 'Mystery Building', address: "323 Main St", city: 'Irvine, CA', zip: 76543, foster_program: false, rank: 9)
        lucille = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: mystery.id)
        lobster = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: mystery.id)
        beethoven = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: mystery.id) 
        barey = Pet.create(adoptable: false, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: mystery.id)
        
        visit "/admin/shelters/#{mystery.id}"   

        expect(page).to have_content("Adopted pets: 2")
    end 

    it 'action required section lists all pets with pending applications' do
        mystery = Shelter.create!(name: 'Mystery Building', address: "323 Main St", city: 'Irvine, CA', zip: 76543, foster_program: false, rank: 9)
        application_1 = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "CO", zipcode: 80009, status:"Pending", description:"I love dogs so much and have lots of food for them")
        application_2 = Application.create!(name: "Cindy Smith", street: "727 Lane road", city: "Rockville", state: "CA", zipcode: 95148, status:"Pending", description:"I have a big yard them to run all day")
        application_3 = Application.create!(name: "Ryan Scott", street: "21 Longwalk street", city: "Denver", state: "CO", zipcode: 34687, status:"Approved", description:"I have lots of time to play fetch")
        lucille = application_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: mystery.id)
        lobster = application_2.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: mystery.id)
        charlie = application_3.pets.create!(adoptable: false, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: mystery.id)
        
        visit "/admin/shelters/#{mystery.id}"   
    
        expect(page).to have_content("Action Required")
        expect(page).to have_content("Lucille")
        expect(page).to have_content("Lobster")
        expect(page).to_not have_content("Charlie")
    end 

    it 'each pet in the action required section has link to the admin application page ' do
        mystery = Shelter.create!(name: 'Mystery Building', address: "323 Main St", city: 'Irvine, CA', zip: 76543, foster_program: false, rank: 9)
        application_1 = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "CO", zipcode: 80009, status:"Pending", description:"I love dogs so much and have lots of food for them")
        application_2 = Application.create!(name: "Cindy Smith", street: "727 Lane road", city: "Rockville", state: "CA", zipcode: 95148, status:"Pending", description:"I have a big yard them to run all day")
        application_3 = Application.create!(name: "Ryan Scott", street: "21 Longwalk street", city: "Denver", state: "CO", zipcode: 34687, status:"Approved", description:"I have lots of time to play fetch")
        lucille = application_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: mystery.id)
        lobster = application_2.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: mystery.id)
        
        visit "/admin/shelters/#{mystery.id}"

        within "#pets-#{lucille.id}" do
            expect(page).to have_link("Review Application")
            expect(page).to have_content("Lucille")

            click_link("Review Application")

            expect(current_path).to eq("/admin/applications/#{application_1.id}")
        end
    end 
end 