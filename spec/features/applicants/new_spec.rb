require 'rails_helper'

RSpec.describe 'the applicants new' do
  # before :each do
  #   @shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
  #   @applicant = Applicant.create!(first_name: 'John', last_name: 'Dough', street_address: '123 Fake Street', city: 'Denver', state: 'CO', zip: 80205, description: "I'm awesome", status: "Approved")
  #   @pet = @applicant.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
  #   @pet_2 = @applicant.pets.create!(name: 'Jake', age: 5, breed: 'Pug', adoptable: true, shelter_id: @shelter.id)
  # end

  it "I see a link to 'Start an Application'" do
    visit '/pets'

    expect(find_link("Start an Application").visible?).to be true
        
    click_link "Start an Application"
    expect(current_path).to eq("/applicants/new")
  end

  it "I am taken to the new application page where I see a form" do
    visit '/applicants/new'

    expect(page.has_field? "first_name").to be true
    expect(page.has_field? "last_name").to be true
    expect(page.has_field? "street_address").to be true
    expect(page.has_field? "city").to be true
    expect(page.has_field? "state").to be true
    expect(page.has_field? "zip").to be true
    expect(page.has_field? "description").to be true
    find_button('Next Step').visible?

  end

  it "I am taken to the new application's show page I see my information, and description and I see an indicator that this application is 'In Progress'" do
    visit '/applicants/new'
    
    fill_in("first_name", with: "Jimmy")
    fill_in("last_name", with: "Dough")
    fill_in("street_address", with: "567 Fake Street")
    fill_in("city", with: "Denver")
    fill_in("state", with: "CO")
    fill_in("zip", with: 80205)
    fill_in("description", with: "I'm more awesome than John")
    
    click_button('Next Step')

    expect(current_path).to eq("/applicants/#{Applicant.last.id}")

    expect(page).to have_content("In Progress")
  end
  
  it "If I fail to fill in any of the form fields and I click submit, then I am taken back to the new applications page and I see a message that I must fill in those fields." do
    visit '/applicants/new'
    
    fill_in("street_address", with: "567 Fake Street")
    
    click_button('Next Step')
    
    expect(current_path).to eq("/applicants/new")
    expect(page).to have_content("Missing Required Info")

  end
end