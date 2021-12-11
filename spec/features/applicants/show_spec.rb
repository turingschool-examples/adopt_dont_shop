require 'rails_helper'

RSpec.describe 'applicant show' do
  before(:each) do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet1 = @shelter.pets.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true)
    @pet2 = @shelter.pets.create(name: 'Toby', age: 3, breed: 'Great Dane', adoptable: true)
    @pet3 = @shelter.pets.create(name: 'Dixie', age: 4, breed: 'Lab', adoptable: true)
    @applicant = Applicant.create(name: 'Russell Rockwood', address: '1065 Walnut St', city: 'Bremerton', state: 'WA', zip: 98310)
  end

  it 'has a text box to search pets by name' do
    visit "/applicants/#{@applicant.id}"
    expect(page).to have_button("Search")
  end

  it 'lists pets with partial matches' do
    visit "/applicants/#{@applicant.id}"

    fill_in 'Search', with: "oby"
    click_on("Search")

    expect(page).to have_content(@pet1.name)
    expect(page).to have_content(@pet2.name)
    expect(page).to_not have_content(@pet3.name)
  end
end
