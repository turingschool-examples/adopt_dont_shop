require 'rails_helper'

RSpec.describe 'Admin Shelters index page' do 
  it 'shows a list of all shelters in reverse alphabetical order' do 
    shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)  

    visit('/admin/shelters')

    expect(current_path).to eq('/admin/shelters')
    expect(shelter_2.name).to appear_before(shelter_3.name)
    expect(shelter_3.name).to appear_before(shelter_1.name)
  end 

  it 'has a section for shelters with pending applications' do 
      shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      shelter2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      shelter3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
      pet1 = shelter1.pets.create!(adoptable: true, age: 3, breed: "Labrador Retriever", name: 'Bailey')
      pet2 = shelter1.pets.create!(adoptable: true, age: 1, breed: "French Bulldog", name: 'Bella')
      pet3 = shelter2.pets.create!(adoptable: false, age: 4, breed: "German Shepard", name: 'Max')
      pet4 = shelter3.pets.create!(adoptable: true, age: 6, breed: "Golden Retriever", name: 'Molly')
      application1 = Application.create!(applicant_name: 'Jacob Yarborough', 
                                         street_address: '123 Main Street', 
                                         city: 'Denver', 
                                         state: 'CO',
                                         zipcode: '80223',
                                         application_status: 'Pending',
                                         why: 'I love dogs')
      application2 = Application.create!(applicant_name: 'Joe Smith', 
                                         street_address: '456 North Street', 
                                         city: 'Denver', 
                                         state: 'CO',
                                         zipcode: '80202',
                                         application_status: 'Pending',
                                         why: 'I currently have two other dogs')
      ApplicationPet.create(pet_id: pet1.id, application_id: application1.id)
      ApplicationPet.create(pet_id: pet4.id, application_id: application2.id)

      visit('/admin/shelters')

      expect(current_path).to eq('/admin/shelters')
      expect(page).to have_content('Shelters with Pending Applications')
      save_and_open_page
      within '#pending_apps' do 
        expect(page).to have_content(shelter1.name)
        expect(page).to have_content(shelter3.name) 
      end
  end 
end 