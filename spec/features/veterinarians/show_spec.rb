require 'rails_helper'

RSpec.describe 'the veterinarian show' do
  it "shows the veterinarian and all it's attributes" do
    vet_office = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
    vet = Veterinarian.create(name: 'Taylor', review_rating: 10, on_call: false, veterinary_office_id: vet_office.id)

    visit "/veterinarians/#{vet.id}"

    expect(page).to have_content(vet.name)
    expect(page).to have_content(vet.review_rating)
    expect(page).to have_content("Not on call")
    expect(page).to have_content(vet_office.name)
  end

  it "allows the user to delete a veterinarian" do
    vet_office = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
    vet = Veterinarian.create(name: 'Taylor', review_rating: 10, on_call: false, veterinary_office_id: vet_office.id)

    visit "/veterinarians/#{vet.id}"

    click_on("Delete #{vet.name}")

    expect(page).to have_current_path('/veterinarians')
    expect(page).to_not have_content(vet.name)
  end
end

# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
