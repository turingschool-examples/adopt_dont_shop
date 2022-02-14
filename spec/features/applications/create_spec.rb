require 'rails_helper'

 RSpec.describe 'Create Application' do
   before(:each) do
     @application_1 = Application.create!(name: "Michael Hicks", address: "858 S Emerson St", city: "Dever", state: "CO", zipcode: "80211", description: "I'm a really responsible adult!", status: "Pending")
     @application_2 = Application.create(name: "Suzanne Roth", address: "9406 Oakmont Rd", city: "Albuquerque", state: "NM", zipcode: "87111", description: "Best dog mom ever!", status: "Accepted")

   end
   describe 'new application' do
     it "can display the application form" do
       visit '/applications/new'

       expect(page).to have_content("New Application")
       expect(find('form')).to have_content("Name")
       expect(find('form')).to have_content("Street address")
       expect(find('form')).to have_content("City")
       expect(find('form')).to have_content("State")
       expect(find('form')).to have_content("Zip code")
     end
   end
 end
