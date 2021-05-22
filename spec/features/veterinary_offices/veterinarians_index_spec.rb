# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'the veterinary offices veterinarians index' do
  before(:each) do
    @vet_office_1 = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
    @vet_office_2 = VeterinaryOffice.create(name: 'Vets R Us', boarding_services: true, max_patient_capacity: 20)
    @not_on_call_vet = Veterinarian.create(name: 'Taylor', review_rating: 10, on_call: false,
                                           veterinary_office_id: @vet_office_1.id)
    @vet_1 = Veterinarian.create(name: 'Taylor', review_rating: 10, on_call: true,
                                 veterinary_office_id: @vet_office_1.id)
    @vet_2 = Veterinarian.create(name: 'Jim', review_rating: 8, on_call: true, veterinary_office_id: @vet_office_1.id)
    @vet_3 = Veterinarian.create(name: 'Sarah', review_rating: 9, on_call: true, veterinary_office_id: @vet_office_2.id)
    @vet_4 = Veterinarian.create(name: 'John', review_rating: 2, on_call: true, veterinary_office_id: @vet_office_2.id)
  end

  it 'lists all the veterinarians associated with the office, with their attributes' do
    visit "/veterinary_offices/#{@vet_office_1.id}/veterinarians"

    within "#veterinarian-#{@vet_1.id}" do
      expect(page).to have_content(@vet_1.name)
      expect(page).to have_content(@vet_1.review_rating)
      expect(page).to have_content(@vet_office_1.name)
    end

    within "#veterinarian-#{@vet_2.id}" do
      expect(page).to have_content(@vet_2.name)
      expect(page).to have_content(@vet_2.review_rating)
    end

    expect(page).to_not have_content(@vet_3.name)
  end

  it 'displays a link to edit each veterinarian' do
    visit "/veterinary_offices/#{@vet_office_1.id}/veterinarians"

    expect(page).to have_link("Edit #{@vet_1.name}")
    expect(page).to have_link("Edit #{@vet_2.name}")

    click_link("Edit #{@vet_1.name}")
    expect(page).to have_current_path("/veterinarians/#{@vet_1.id}/edit")
  end

  it 'displays a link to delete each veterinarian' do
    visit "/veterinary_offices/#{@vet_office_1.id}/veterinarians"

    expect(page).to have_link("Delete #{@vet_1.name}")
    expect(page).to have_link("Delete #{@vet_2.name}")

    click_link("Delete #{@vet_1.name}")

    expect(page).to have_current_path('/veterinarians')
    expect(page).to_not have_content(@vet_1.name)
  end

  it 'displays a link to create a new veterinarian' do
    visit "/veterinary_offices/#{@vet_office_1.id}/veterinarians"

    expect(page).to have_link('Create a Veterinarian')
    click_on('Create a Veterinarian')
    expect(page).to have_current_path("/veterinary_offices/#{@vet_office_1.id}/veterinarians/new")
  end

  it 'displays a form for a number value' do
    visit "/veterinary_offices/#{@vet_office_1.id}/veterinarians"

    expect(page).to have_content('Only display veterinarians with a review rating of at least...')
    expect(page).to have_select('review_rating')
  end

  it 'only displays records above the given return value' do
    visit "/veterinary_offices/#{@vet_office_1.id}/veterinarians"

    find("#review_rating option[value='5']").select_option
    click_button('Filter')

    expect(page).to have_content(@vet_1.name)
    expect(page).to have_content(@vet_2.name)
    expect(page).to_not have_content(@vet_4.name)
  end

  it 'allows the user to sort veterinarians alphabetically' do
    visit "/veterinary_offices/#{@vet_office_2.id}/veterinarians"

    expect(@vet_3.name).to appear_before(@vet_4.name)

    expect(page).to have_link('Sort alphabetically')
    click_on('Sort alphabetically')

    expect(@vet_4.name).to appear_before(@vet_3.name)
  end
end
