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

  it 'adds adobtable pet to application' do
    visit "/applicants/#{@applicant.id}"

    fill_in 'Search', with: "oby"
    click_on("Search")
    click_button("Adopt", :match => :first)

    expect(page).to have_content(@pet1.name)
    expect(page).to_not have_content(@pet2.name)
    expect(page).to_not have_content(@pet3.name)
  end

  it 'renders submit button and reason for adoption text field' do
    visit "/applicants/#{@applicant.id}"

    fill_in 'Search', with: "Dixie"
    click_on("Search")
    click_button("Adopt")

    expect(page).to have_field("description")
    expect(page).to have_selector(:link_or_button, 'Submit Application')
  end
#   And I click a button to submit this application
# Then I am taken back to the application's show page
# And I see an indicator that the application is "Pending"
# And I see all the pets that I want to adopt
# And I do not see a section to add more pets to this application
  it 'renders correct info for pending application' do
    visit "/applicants/#{@applicant.id}"

    fill_in 'Search', with: "Dixie"
    click_on("Search")
    click_button("Adopt")
    fill_in 'description', with: "I get along with this dog."
    click_button("Submit Application")

    expect(page).to have_content("Pending")
    expect(page).to have_content("Dixie")
    expect(page).to_not have_field(:search)
  end

end
