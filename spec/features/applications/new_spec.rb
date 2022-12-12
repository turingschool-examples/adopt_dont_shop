require "rails_helper"

RSpec.describe "new application" do
  it "application form" do
    visit "/pets"

    click_link "Start an Application"
    
   
    expect(page).to have_current_path("/applications/new")
    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Street Address')
    expect(find('form')).to have_content('City')
    expect(find('form')).to have_content('State')
    expect(find('form')).to have_content('Zipcode')
  end

  it "has a filled in application" do
    visit "applications/new"

    fill_in('name', with: "Shaggy")
    fill_in('street_address', with: "123 Mystery Lane")
    fill_in('city', with: "Denver")
    fill_in('state', with: "Colorado")
    fill_in('zip_code', with: "80203")
    # fill_in('description', with: "xxx")
  
    click_button("Submit Application")

    new_application = Application.last
    expect(current_path).to eq("/applications/#{new_application.id}")
  end

  describe 'user story 3' do
    describe '/applications/new' do
      describe 'if I do not fill out application and click submit' do 
        it 'redirects me to the new application page and shows an error message' do
          visit "/applications/new"
         
          fill_in('name', with: "Shaggy")
       
          click_button("Submit Application") 

          expect(current_path).to eq('/applications/new')
          expect(page).to have_content('Error: Please fill in all fields')
        end
      end
    end
  end
end