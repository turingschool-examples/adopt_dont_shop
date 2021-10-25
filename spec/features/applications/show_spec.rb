require 'rails_helper' 

RSpec.describe 'guest applications show page' do 
    it 'shows an application and its attributes as well as pets on the application' do 
        shelter1 = Shelter.create!(foster_program: true,
                                   name: 'Rocky Mountain Dog Shelter',
                                   city: 'Denver',
                                   rank: 1)
        pet1 = shelter1.pets.create!(adoptable: true,
                                     age: 3,
                                     breed: "Labrador Retriever",
                                     name: 'Bailey')
        pet2 = shelter1.pets.create!(adoptable: true,
                                     age: 1,
                                     breed: "French Bulldog",
                                     name: 'Bella')
        pet3 = shelter1.pets.create!(adoptable: false,
                                     age: 4,
                                     breed: "German Shepard",
                                     name: 'Max')
        application1 = Application.create!(applicant_name: 'Jacob Yarborough', 
                                           street_address: '123 Main Street', 
                                           city: 'Denver', 
                                           state: 'CO',
                                           zipcode: '80223',
                                           application_status: 'Pending',
                                           why: 'I love dogs')
        application1.pets << pet1
        application1.pets << pet2

        visit "/applications/#{application1.id}"

        expect(current_path).to eq("/applications/#{application1.id}")
        expect(page).to have_content(application1.applicant_name)
        expect(page).to have_content(application1.street_address)
        expect(page).to have_content(application1.city)
        expect(page).to have_content(application1.state)
        expect(page).to have_content(application1.zipcode)
        expect(page).to have_content(pet1.name)
        expect(page).to have_content(pet2.name)
        expect(page).to have_content(application1.why)
        expect(page).to have_content(application1.application_status)
    end 
end 