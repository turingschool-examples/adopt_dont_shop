require 'rails_helper'

RSpec.describe 'admin applications show page' do
  it 'has a button to approve the pet' do
    application = Application.create!(name: "Jerry Rice", street_address: "123 Main Street", city: "Honolulu", state: "HI", zip_code: 12345, description: "We love doggos!")
    northshore = Shelter.create!(foster_program: true, name: "North Shore Animal Hospital", city: "Long Island", rank: 3)
    frenchie = Pet.create!(adoptable: true, age: 1, breed: "French Bulldog", name: "Frenchie", shelter_id: northshore.id)
    fRENCHToasT = Pet.create!(adoptable: true, age: 4, breed: "French toast", name: "FReNCH ToAsT", shelter_id: northshore.id)
    frenchie_application = PetApplication.create!(application_id: application.id, pet_id: frenchie.id, status: application.status)

    visit "/admin/applications/#{application.id}"
    expect(current_path).to eq("/admin/applications/#{application.id}")

    click_button("Approve")
    expect(current_path).to eq("/admin/applications/#{application.id}")
    expect(page).to have_content("Accepted")
  end
end
