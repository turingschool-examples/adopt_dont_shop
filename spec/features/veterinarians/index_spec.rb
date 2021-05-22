# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'the veterinarians index' do
  it 'lists all the veterinarians with their attributes' do
    vet_office = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
    vet_1 = Veterinarian.create(name: 'Taylor', review_rating: 10, on_call: true, veterinary_office_id: vet_office.id)
    vet_2 = Veterinarian.create(name: 'Jim', review_rating: 8, on_call: true, veterinary_office_id: vet_office.id)

    visit '/veterinarians'

    expect(page).to have_content(vet_1.name)
    expect(page).to have_content(vet_1.review_rating)
    expect(page).to have_content(vet_office.name)

    expect(page).to have_content(vet_2.name)
    expect(page).to have_content(vet_2.review_rating)
    expect(page).to have_content(vet_office.name)
  end

  it 'only shows on call veterinarians' do
    vet_office = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
    vet_1 = Veterinarian.create(name: 'Taylor', review_rating: 10, on_call: false, veterinary_office_id: vet_office.id)
    vet_2 = Veterinarian.create(name: 'Jim', review_rating: 8, on_call: true, veterinary_office_id: vet_office.id)

    visit '/veterinarians'

    expect(page).to_not have_content(vet_1.name)
  end

  it 'displays a link to edit each veterinarian' do
    vet_office = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
    vet_1 = Veterinarian.create(name: 'Taylor', review_rating: 10, on_call: true, veterinary_office_id: vet_office.id)
    vet_2 = Veterinarian.create(name: 'Jim', review_rating: 8, on_call: true, veterinary_office_id: vet_office.id)

    visit '/veterinarians'

    expect(page).to have_link("Edit #{vet_1.name}")
    expect(page).to have_link("Edit #{vet_2.name}")

    click_link("Edit #{vet_1.name}")

    expect(page).to have_current_path("/veterinarians/#{vet_1.id}/edit")
  end

  it 'displays a link to delete each veterinarian' do
    vet_office = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
    vet_1 = Veterinarian.create(name: 'Taylor', review_rating: 10, on_call: true, veterinary_office_id: vet_office.id)
    vet_2 = Veterinarian.create(name: 'Jim', review_rating: 8, on_call: true, veterinary_office_id: vet_office.id)

    visit '/veterinarians'

    expect(page).to have_link("Delete #{vet_1.name}")
    expect(page).to have_link("Delete #{vet_2.name}")

    click_link("Delete #{vet_1.name}")

    expect(page).to have_current_path('/veterinarians')
    expect(page).to_not have_content(vet_1.name)
  end
end
