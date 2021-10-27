require 'rails_helper'

RSpec.describe 'the admin shelters index' do
  before :each do
    @maxfund = Shelter.create(
      name: 'Maxfund',
      city: 'Denver',
      foster_program: false,
      rank: 9
    )
    @alpha = Shelter.create(
      name: 'Alpha',
      city: 'Denver',
      foster_program: true,
      rank: 1
    )
    @beta = Shelter.create(
      name: 'Beta',
      city: 'Denver',
      foster_program: true,
      rank: 2
    )
  end

  it 'lists all shelters in reverse alphabetical order' do
    visit '/admin/shelters'

    expect(@maxfund.name).to appear_before(@beta.name)
    expect(@beta.name).to appear_before(@alpha.name)
  end

  it 'has a section for shelters with open applications' do
    fluffy = @maxfund.pets.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Fluffy')
    app1 = Application.create(
      name:        'CatMan',
      address:     '123 Main Street',
      city:        'Denver',
      state:       'CO',
      zip:         '80204',
      description: 'I WANT ALL THE CATS!',
      status:      'Pending'
    )
    app1.pets << fluffy
    visit '/admin/shelters'

    within('div#pending-applications') do
      expect(page).to have_content @maxfund.name
      expect(page).to_not have_content @alpha.name
      expect(page).to_not have_content @beta.name
    end

    buffy = @alpha.pets.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle')
    app2 = Application.create(
      name:        'CatMan',
      address:     '123 Main Street',
      city:        'Denver',
      state:       'CO',
      zip:         '80204',
      description: 'I WANT ALL THE CATS!',
      status:      'Pending'
    )
    app2.pets << buffy

    visit '/admin/shelters'
    within('div#pending-applications') do
      expect(page).to have_content @maxfund.name
      expect(page).to have_content @alpha.name
      expect(page).to_not have_content @beta.name
    end
  end
end
