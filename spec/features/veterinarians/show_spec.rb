# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'the veterinarian show' do
  it "shows the veterinarian and all it's attributes" do
    vet_office = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
    vet = Veterinarian.create(name: 'Taylor', review_rating: 10, on_call: false, veterinary_office_id: vet_office.id)

    visit "/veterinarians/#{vet.id}"

    expect(page).to have_content(vet.name)
    expect(page).to have_content(vet.review_rating)
    expect(page).to have_content('Not on call')
    expect(page).to have_content(vet_office.name)
  end

  it 'allows the user to delete a veterinarian' do
    vet_office = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
    vet = Veterinarian.create(name: 'Taylor', review_rating: 10, on_call: false, veterinary_office_id: vet_office.id)

    visit "/veterinarians/#{vet.id}"

    click_on("Delete #{vet.name}")

    expect(page).to have_current_path('/veterinarians')
    expect(page).to_not have_content(vet.name)
  end
end
