require 'rails_helper'

RSpec.describe 'the applicants show' do
  before :each do
    @shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @applicant = Applicant.create!(first_name: 'John', last_name: 'Dough', street_address: '123 Fake Street', city: 'Denver', state: 'CO', zip: 80205, description: "I'm awesome", status: 'pending')
    @pet = @applicant.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
    @pet_2 = @applicant.pets.create!(name: 'Jake', age: 5, breed: 'Pug', adoptable: true, shelter_id: @shelter.id)
  end

  it "shows the name of the applicant" do
    visit "/applicants/#{@applicant.id}"

    expect(page).to have_content(@applicant.first_name)
    expect(page).to have_content(@applicant.last_name)

  end

  it 'shows the full Address of the Applicant including street address, city, state, and zip code' do
    visit "/applicants/#{@applicant.id}"

    
    expect(page).to have_content(@applicant.street_address)
    expect(page).to have_content(@applicant.city)
    expect(page).to have_content(@applicant.state)
    expect(page).to have_content(@applicant.zip)
  end
  
  it 'shows the description of why the applicant says they would be a good home for this pets' do
    visit "/applicants/#{@applicant.id}"
    
    expect(page).to have_content(@applicant.description)
  end
  
  it 'names of all pets that this application is for (all names of pets should be links to their show page)' do 
    visit "/applicants/#{@applicant.id}"
    
    within("#applicant-#{@applicant.id}") do
      expect(page).to have_content(@pet.name)
      expect(page).to have_content(@pet_2.name)
      expect(find_link("#{@pet.name}").visible?).to be true
      expect(find_link("#{@pet_2.name}").visible?).to be true
    end
    
    click_link "#{@pet.name}"
    expect(current_path).to eq("/pets/#{@pet.id}")

  end

  it 'The Applications status, either In Progress, Pending, Accepted, or Rejected' do
    visit "/applicants/#{@applicant.id}"

    expect(page).to have_content(@applicant.status)
  end
end
