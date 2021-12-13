require 'rails_helper'

RSpec.describe 'new application form', type: :feature do
 describe 'page content' do
   it 'has form field labels' do
     visit 'applications/new'

     expect(page).to have_content("Name (First Last)")
     expect(page).to have_content("Street Address")
     expect(page).to have_content("City")
     expect(page).to have_content("State")
     expect(page).to have_content("Zip Code")
   end

   it 'has input fields' do
     visit 'applications/new'

      expect(page).to have_field('applicant_name')
      expect(page).to have_field('street_address')
      expect(page).to have_field('city')
      expect(page).to have_field('state')
      expect(page).to have_field('zip_code')

      expect(page).to have_button("Save")
   end
 end

 describe 'form behavior' do
   it 'submits user filled in information and redirects to application show page' do
     visit '/applications/new'

     fill_in 'applicant_name', with: 'Bryan Oleary'
     fill_in 'street_address', with: '1356 west ave'
     fill_in 'city', with: 'Boulder'
     select "Colorado", :from => "state"
     fill_in 'zip_code', with: '13326'

     click_button 'Save'

     expect(current_path).to_not eq('/applications/new')

     expect(page).to have_content("Applicant Name: Bryan Oleary")
     expect(page).to have_content("Applicant Address: 1356 west ave, Boulder, CO, 13326")
     expect(page).to have_content("Boulder")
     expect(page).to have_content("CO")
     expect(page).to have_content("13326")
     expect(page).to have_content("Pet Name(s):")
   end

   it 'uses method from controller for states dropdown method' do
     visit '/applications/new'

     select "Colorado", :from => "state"
     select "Massachusetts", :from => "state"
     select "New York", :from => "state"
     select "Oklahoma", :from => "state"
     select "South Carolina", :from => "state"
     select "District of Columbia", :from => "state"
     select "Arkansas", :from => "state"
   end

   it 'displays a flash message when forms are not filled out correctly and returns to form page' do
     visit '/applications/new'

     fill_in 'applicant_name', with: 'Bryan Oleary'

     click_button 'Save'

     expect(current_path).to eq("/applications/new")
     expect(page).to have_content("Error: Street address can't be blank, City can't be blank, Zip code can't be blank, Zip code is not a number")

     fill_in 'applicant_name', with: 'Bryan Oleary'
     fill_in 'street_address', with: '1356 west ave'
     fill_in 'city', with: 'Boulder'
     select "Colorado", :from => "state"
     fill_in 'zip_code', with: '13326'

     click_button 'Save'

     expect(current_path).to_not eq('/applications/new')
     expect(page).to have_no_content("Error")
   end
 end
end
