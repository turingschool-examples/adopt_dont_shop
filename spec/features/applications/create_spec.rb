require 'rails_helper'

RSpec.describe 'application creation' do 
    before(:each) do 
        @application = Application.create!(name: "Steve Rogers", street_address: "990 Logan St", city: "Denver", state: "CO", zip_code: "80203", description: "Lover of dogs and avid poo-picker-upper.", status: "In Progress")
    end

    describe 'the application new' do
        it 'renders the new form' do 
            visit "/applications/new"
            
            expect(page).to have_content("New Application")
            expect(find('form')).to have_content("Name")
            expect(find('form')).to have_content("Street address")
            expect(find('form')).to have_content("City")
            expect(find('form')).to have_content("State")
            expect(find('form')).to have_content("Zip code")
        end
    end
    
    describe 'the application create' do 
        context 'given valid data' do
            it 'creates the application and redirects to the application show' do 
                visit "/applications/new"
                
                fill_in 'Name', with: "Steve Rogers"
                fill_in 'Street address', with: "990 Logan St"
                fill_in 'City', with: "Denver"
                fill_in 'State', with: "CO"
                fill_in 'Zip code', with: "80203"
                click_button 'Submit'
                expect(page).to have_current_path("/applications/#{@application.id + 1}")
                expect(page).to have_content("Steve Rogers")
            end
        end
        
        context 'given invalid data' do 
            it 're-renders the new form' do 
                visit "/applications/new"
                click_button 'Submit'
                expect(page).to have_current_path("/applications/new")
                expect(page).to have_content("Error: Name can't be blank, Street address can't be blank, City can't be blank, State can't be blank, Zip code can't be blank")
            end
        end
    end
end