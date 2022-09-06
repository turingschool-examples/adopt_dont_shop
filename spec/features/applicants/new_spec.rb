require 'rails_helper'

RSpec.describe 'the applicants new' do
  
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

    expect(Applicant.count).to eq(0)    
    save_and_open_page
    expect(current_path).to eq("/applicants/new")
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("City can't be blank")
    expect(page).to have_content("State can't be blank")
    expect(page).to have_content("Zip can't be blank")
    expect(page).to have_content("Description can't be blank")

  end
  
end