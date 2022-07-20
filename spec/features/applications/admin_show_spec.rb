require 'rails_helper'

RSpec.describe 'admin applications show page' do
  it 'has a button to approve the pet' do
    application = Application.create!(name: "Jerry Rice", street_address: "123 Main Street", city: "Honolulu", state: "HI", zip_code: 12345, description: "We love doggos!")
    northshore = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)
    frenchie = Pet.create!(adoptable: true, age: 1, breed: "French Bulldog", name: "Frenchie", shelter_id: northshore.id)
    fRENCHToasT = Pet.create!(adoptable: true, age: 4, breed: "French toast", name: "FReNCH ToAsT", shelter_id: northshore.id)
    frenchie_application = PetApplication.create!(application_id: application.id, pet_id: frenchie.id, status: application.status)

    visit "/admin/applications/#{application.id}"
    expect(current_path).to eq("/admin/applications/#{application.id}")

    click_button("Approve")
    expect(current_path).to eq("/admin/applications/#{application.id}")
    expect(page).to have_content("Accepted")
  end

  it 'has a button to reject the pet' do
    application = Application.create!(name: "Jerry Rice", street_address: "123 Main Street", city: "Honolulu", state: "HI", zip_code: 12345, description: "We love doggos!")
    northshore = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)
    frenchie = Pet.create!(adoptable: true, age: 1, breed: "French Bulldog", name: "Frenchie", shelter_id: northshore.id)
    fRENCHToasT = Pet.create!(adoptable: true, age: 4, breed: "French toast", name: "FReNCH ToAsT", shelter_id: northshore.id)
    frenchie_application = PetApplication.create!(application_id: application.id, pet_id: frenchie.id, status: application.status)

    visit "/admin/applications/#{application.id}"
    expect(current_path).to eq("/admin/applications/#{application.id}")

    click_button("Reject")

    expect(current_path).to eq("/admin/applications/#{application.id}")
    expect(page).to have_content("Rejected")
  end

  it 'Approved/Rejected pets do not affect other applications' do
    jerry_application = Application.create!(name: "Jerry Rice", street_address: "123 Main Street", city: "Honolulu", state: "HI", zip_code: 12345, description: "We love doggos!")
    tony_application = Application.create!(name: "Tony Bologna", street_address: "123 Chicago Ave", city: "Chicago", state: "IL", zip_code: 54321, description: "We love Kangaroos!")
    northshore = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3, street_address: "456 Shore Drive", state: "NY", zip_code: 15151)
    islandlake = Shelter.create!(foster_program: true, name: "Island Lake Animal Hospital", city: "Denver", rank: 8, street_address: "789 River Road", state: "CO", zip_code: 11556)
    banfield = Shelter.create!(foster_program: true, name: "Banfield Animal Hospital", city: "Orlando", rank: 9, street_address:"923 Oscar Meyer Lane", state: "FL", zip_code: 65425)
    spot = Pet.create!(adoptable: true, age: 2, breed: "Dalmatian", name: "Spot", shelter_id: northshore.id)
    fRENCHToasT = Pet.create!(adoptable: true, age: 4, breed: "French toast", name: "FReNCH ToAsT", shelter_id: banfield.id)
    # spot_application = PetApplication.create!(application_id: jerry_application.id, pet_id: spot.id, status: jerry_application.status)
    fRENCHToasT_application = PetApplication.create!(application_id: jerry_application.id, pet_id: fRENCHToasT.id, status: jerry_application.status)
    # spot_application1 = PetApplication.create!(application_id: tony_application.id, pet_id: spot.id, status: tony_application.status)
    fRENCHToasT_application1 = PetApplication.create!(application_id: tony_application.id, pet_id: fRENCHToasT.id, status: tony_application.status)

    visit "/admin/applications/#{jerry_application.id}"
    expect(current_path).to eq("/admin/applications/#{jerry_application.id}")

    within '#pet-0' do
    click_button("Reject")
    expect(current_path).to eq("/admin/applications/#{jerry_application.id}")
    expect(page).to have_content("Rejected")
    expect(page).to_not have_button("Reject")

    visit "/admin/applications/#{tony_application.id}"

    expect(page).to have_button("Reject")
    expect(page).to have_button("Approve")
    click_button("Approve")
    expect(page).to_not have_button("Approve")
    end
  end
end
