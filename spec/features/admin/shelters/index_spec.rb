require 'rails_helper'

RSpec.describe 'the admin shelters index page' do
  it 'shows all shelters in the system in reverse alphabetical order' do
    shelter1 = Shelter.create!(foster_program: true, name: 'Gally', city: 'Denver', rank: 21)
    shelter2 = Shelter.create!(foster_program: true, name: 'Fally', city: 'Denver', rank: 21)
    shelter3 = Shelter.create!(foster_program: true, name: 'Eally', city: 'Denver', rank: 21)
    shelter4 = Shelter.create!(foster_program: true, name: 'Dally', city: 'Denver', rank: 21)

    visit '/admin/shelters'

    expect(shelter1.name).to appear_before(shelter2.name)

    expect(shelter1.name).to appear_before(shelter4.name)

    expect(shelter1.name).to appear_before(shelter3.name)

    expect(shelter3.name).to appear_before(shelter4.name)

    expect(shelter2.name).to appear_before(shelter4.name)

    expect(shelter4.name).to_not appear_before(shelter2.name)
  end

  it 'lists shelters that have pending applications' do
    shelter1 = Shelter.create!(foster_program: true, name: 'Gally', city: 'Denver', rank: 21)
    shelter2 = Shelter.create!(foster_program: true, name: 'Fally', city: 'Denver', rank: 21)
    shelter3 = Shelter.create!(foster_program: true, name: 'Eally', city: 'Denver', rank: 21)
    shelter4 = Shelter.create!(foster_program: true, name: 'Dally', city: 'Denver', rank: 21)

    pet1 = shelter1.pets.create!(adoptable: true, age: 9, breed: 'Labrador', name: 'Dante')
    pet2 = shelter2.pets.create!(adoptable: true, age: 9, breed: 'Labrador', name: 'Spot')
    pet3 = shelter3.pets.create!(adoptable: true, age: 9, breed: 'Labrador', name: 'Spike')
    pet4 = shelter4.pets.create!(adoptable: true, age: 9, breed: 'Labrador', name: 'Suzan')

    application1 = Application.create!(name: 'Sylvester Tommy', street_address: '1827 Vincent Ave', city: 'Halifax',
                                       state: 'Colorado', zip_code: '19274', status: 'Pending')

    application2 = Application.create!(name: 'Jamie James', street_address: '1827 Vincent Ave', city: 'Halifax',
                                       state: 'Colorado', zip_code: '19274', status: 'Pending')

    ap1 = ApplicationPet.create!(application_id: application1.id, pet_id: pet1.id)
    ap2 = ApplicationPet.create!(application_id: application2.id, pet_id: pet3.id)

    visit '/admin/shelters'

    expect(page).to have_content('Shelters with Pending Applications')
    within('div#pendingApps') do
      expect(page).to have_content('Gally')

      expect(page).to have_content('Eally')
    end
  end
end
