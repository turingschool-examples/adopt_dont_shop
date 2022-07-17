require 'rails_helper'

RSpec.describe 'new applications' do
  it 'links to a new form to apply for a pet' do
    heavenly = Shelter.create!(name: 'Heavenly pets', city: 'Aurora, CO', foster_program: true, rank: 7)
    mystery = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)

    scooby = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: mystery.id)
    scrappy = Pet.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: mystery.id)
    hairlesson = Pet.create!(adoptable: true, age: 1, breed: 'Sphynx', name: 'George Hairlesson', shelter_id: heavenly.id)
    charlie = Pet.create!(adoptable: true, age: 3, breed: 'GSD', name: 'Charlie', shelter_id: heavenly.id)

    visit "/pets"

    expect(page).to have_link('Start an Application')
    click_link('Start an Application')
    expect(current_path).to eq('/applications/new')
  end

  it 'is a form to apply for a pet' do
    visit '/applications/new'

    fill_in('Name', with: 'Ben Silverstein')
    fill_in('Street address', with: '621 Aspen Dr')
    fill_in('City', with: 'Westminster')
    fill_in('State', with: 'CO')
    fill_in('Zip code', with: '80021')
    click_button 'Start Application'

    expect(page).to have_content('Ben Silverstein')
  end

  it 'is an incomplete form' do
    visit '/applications/new'

    fill_in('Name', with: 'Ben Silverstein')
    fill_in('Street address', with: '621 Aspen Dr')
    fill_in('City', with: 'Westminster')
    fill_in('State', with: 'CO')
    click_button 'Start Application'

    expect(page).to have_content("Error: Zip code can't be blank, Zip code is not a number, Zip code is the wrong length (should be 5 characters")
  end
end
