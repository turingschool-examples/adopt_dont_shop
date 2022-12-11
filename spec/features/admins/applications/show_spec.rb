require 'rails_helper'

RSpec.describe 'admin application show' do
  it 'has a button for approval next to each pet applied for' do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet2 = Pet.create(name: 'Spot', age: 4, breed: 'Poodle', adoptable: true, shelter_id: shelter.id)    
    application1 = pet1.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")
    application1.pets << pet2

    visit "/admin/applications/#{ application1.id }"

    within("div##{pet1.id}") do
      expect(page).to have_button("Approve")
      expect(page).to have_content(pet1.name)
    end
    
    within("div##{pet2.id}") do
      expect(page).to have_button("Approve")
      expect(page).to have_content(pet2.name)
    end
  end

  it 'approves application for that pet when you click approve' do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    application1 = pet1.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")

    visit "/admin/applications/#{ application1.id }"
    click_button("Approve")

    expect(page).to have_content("Approved")
    expect(current_path).to eq("/admin/applications/#{ application1.id }")
    expect(page).to_not have_button("Approve")
  end
end
