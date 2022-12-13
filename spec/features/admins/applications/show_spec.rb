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

  it 'has a button for reject next to each pet applied for' do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet2 = Pet.create(name: 'Spot', age: 4, breed: 'Poodle', adoptable: true, shelter_id: shelter.id)    
    application1 = pet1.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")
    application1.pets << pet2

    visit "/admin/applications/#{ application1.id }"

    within("div##{pet1.id}") do
      expect(page).to have_button("Reject")
      expect(page).to have_content(pet1.name)
    end
    
    within("div##{pet2.id}") do
      expect(page).to have_button("Reject")
      expect(page).to have_content(pet2.name)
    end
  end

  it 'rejects application for that pet when you click reject' do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    application1 = pet1.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")
    pet2 = Pet.create(name: 'Spot', age: 4, breed: 'Poodle', adoptable: true, shelter_id: shelter.id)    
    application1.pets << pet2

    visit "/admin/applications/#{ application1.id }"
    
    within("div##{pet1.id}") do
      click_button("Reject")
      expect(page).to have_content("Rejected")
      expect(current_path).to eq("/admin/applications/#{ application1.id }")
      expect(page).to_not have_button("Reject")
      expect(page).to_not have_button("Approve")
    end

    within("div##{pet2.id}") do
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
    end

    visit "/admin/applications/#{ application1.id }"
 
    within("div##{pet1.id}") do
      expect(page).to have_content("Rejected")
      expect(page).to_not have_button("Reject")
      expect(page).to_not have_button("Approve")
    end

    within("div##{pet2.id}") do
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
    end
  end

  it 'one admin application show page does not affect another' do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    application1 = pet1.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")
    application2 = pet1.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")

    visit "/admin/applications/#{ application1.id }"

    within("div##{pet1.id}") do
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
    end

    click_button("Reject")

    expect(page).to have_content("Rejected")
    expect(current_path).to eq("/admin/applications/#{ application1.id }")
    expect(page).to_not have_button("Reject")
    expect(page).to_not have_button("Approve")

    visit "admin/applications/#{ application2.id }"

    within("div##{pet1.id}") do
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
    end
  end

  it 'approves an application if all pets are approved' do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet2 = Pet.create(name: 'Spot', age: 4, breed: 'Poodle', adoptable: true, shelter_id: shelter.id)    
    application1 = pet1.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")
    application1.pets << pet2


    visit "/admin/applications/#{application1.id}"

    within("div##{pet1.id}") do
     click_button("Approve")
    end

    within("div##{pet2.id}") do
      click_on("Approve")
    end

    expect(current_path).to eq("/admin/applications/#{application1.id}")
    expect(page).to have_content("Application Status: Approved")
  end

  it 'changes app status to rejected if one or more pets rejected and all others approved' do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet2 = Pet.create(name: 'Spot', age: 4, breed: 'Poodle', adoptable: true, shelter_id: shelter.id)    
    application1 = pet1.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")
    application1.pets << pet2


    visit "/admin/applications/#{application1.id}"

    within("div##{pet2.id}") do
      click_on("Approve")
    end

    within("div##{pet1.id}") do
     click_button("Reject")
    end

    expect(current_path).to eq("/admin/applications/#{application1.id}")
    expect(page).to have_content("Application Status: Rejected")
  end

  it 'shows pets as unadoptable on pet show page once they have an app that is approved' do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    application1 = pet1.applications.create!(name: 'John Doe', street: '123 N Washington Ave.', city: 'Denver', state: 'Colorado', zip: '91234', applicant_argument: 'caring and loving', app_status: "Pending")

    visit "/pets/#{pet1.id}"
    expect(page).to have_content("true")


    visit "/admin/applications/#{application1.id}"
    click_on("Approve")

    visit "/pets/#{pet1.id}"

    expect(page).to have_content("false")
  end
end
