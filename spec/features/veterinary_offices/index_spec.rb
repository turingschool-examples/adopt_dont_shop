# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'the veterinary offices index' do
  before(:each) do
    @vet_office_1 = VeterinaryOffice.create(name: 'Special Friends', boarding_services: true, max_patient_capacity: 100)
    @vet_office_2 = VeterinaryOffice.create(name: 'Pet Emergency Room', boarding_services: true,
                                            max_patient_capacity: 50)
    @vet_office_3 = VeterinaryOffice.create(name: 'The Country Vet', boarding_services: true, max_patient_capacity: 200)
    @vet_office_1.veterinarians.create(name: 'Morgan', on_call: true, review_rating: 10)
    @vet_office_1.veterinarians.create(name: 'Heather', on_call: true, review_rating: 9)
    @vet_office_3.veterinarians.create(name: 'John', on_call: true, review_rating: 9)
  end

  it 'lists all the vet office names' do
    visit '/veterinary_offices'

    expect(page).to have_content(@vet_office_1.name)
    expect(page).to have_content(@vet_office_2.name)
    expect(page).to have_content(@vet_office_3.name)
  end

  it 'lists the veterinary offices by most recently created first' do
    visit '/veterinary_offices'

    oldest = find("#veterinary-office-#{@vet_office_1.id}")
    mid = find("#veterinary-office-#{@vet_office_2.id}")
    newest = find("#veterinary-office-#{@vet_office_3.id}")

    expect(newest).to appear_before(mid)
    expect(mid).to appear_before(oldest)

    within "#veterinary-office-#{@vet_office_1.id}" do
      expect(page).to have_content("Created at: #{@vet_office_1.created_at}")
    end

    within "#veterinary-office-#{@vet_office_2.id}" do
      expect(page).to have_content("Created at: #{@vet_office_2.created_at}")
    end

    within "#veterinary-office-#{@vet_office_3.id}" do
      expect(page).to have_content("Created at: #{@vet_office_3.created_at}")
    end
  end

  it 'has a link to sort offices by the number of vets they have' do
    visit '/veterinary_offices'

    expect(page).to have_link('Sort by number of veterinarians')
    click_link('Sort by number of veterinarians')

    expect(page).to have_current_path('/veterinary_offices?sort=veterinarian_count')
    expect(@vet_office_1.name).to appear_before(@vet_office_3.name)
    expect(@vet_office_3.name).to appear_before(@vet_office_2.name)
  end

  it 'has a link to update each veterinary office' do
    visit '/veterinary_offices'

    within "#veterinary-office-#{@vet_office_1.id}" do
      expect(page).to have_link("Update #{@vet_office_1.name}")
    end

    within "#veterinary-office-#{@vet_office_2.id}" do
      expect(page).to have_link("Update #{@vet_office_2.name}")
    end

    within "#veterinary-office-#{@vet_office_3.id}" do
      expect(page).to have_link("Update #{@vet_office_3.name}")
    end

    click_on("Update #{@vet_office_1.name}")
    expect(page).to have_current_path("/veterinary_offices/#{@vet_office_1.id}/edit")
  end

  it 'has a link to delete each veterinary office' do
    visit '/veterinary_offices'

    within "#veterinary-office-#{@vet_office_1.id}" do
      expect(page).to have_link("Delete #{@vet_office_1.name}")
    end

    within "#veterinary-office-#{@vet_office_2.id}" do
      expect(page).to have_link("Delete #{@vet_office_2.name}")
    end

    within "#veterinary-office-#{@vet_office_3.id}" do
      expect(page).to have_link("Delete #{@vet_office_3.name}")
    end

    click_on("Delete #{@vet_office_1.name}")
    expect(page).to have_current_path('/veterinary_offices')
    expect(page).to_not have_content(@vet_office_1.name)
  end
end
