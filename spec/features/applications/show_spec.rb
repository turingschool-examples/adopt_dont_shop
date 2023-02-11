require 'rails_helper'

RSpec.describe "#show" do
  before(:each) do
    @pound = Shelter.create!(foster_program: true, name: 'The Pound', city: "Denver", rank: 1)
    @snugglez = @pound.pets.create!(adoptable: true, age: 2, breed: "Tabby Cat", name: 'Snugglez')
    @huy = Application.create!(applicant_name: "Huy Phan", app_street: "123 Park Ave", app_city: "Denver", app_state: "CO", app_zip_code: "80205", description: "Im super cool and stuffy" )
  end

  describe 'user story 1' do
    describe 'When user visits application show page' do
      it 'displays the attributes of the applicant' do

        visit "/applications/#{@huy.id}"

        expect(page).to have_content "#{@huy.applicant_name}'s Application for Pet Adoption"
        expect(page).to have_content "#{@huy.app_street}"
        expect(page).to have_content "Application Status: #{@huy.status}"
      end
    end
  end

  describe 'user story 4' do 
    it 'if an application is "in progress" then there is a field to search for pets' do 

      visit "/applications/#{@huy.id}"

      expect(page).to have_content "Search for Pets by Name:"

      fill_in 'pet_name', with: "Snugglez"
      click_button "Search Pets"
      expect(current_path).to eq "/applications/#{@huy.id}"
      expect(page).to have_content "Snugglez"
    end
  end

  describe 'user story 5' do 
    describe "When I visit an application's show page" do
      it 'should have a button next to the searched pet name to adopt the pet' do 
        visit "/applications/#{@huy.id}"

        fill_in 'pet_name', with: "Snugglez"
        click_button "Search Pets"
        expect(current_path).to eq "/applications/#{@huy.id}"
        expect(page).to have_content "Snugglez"

        click_button "Adopt this Pet"

        expect(current_path).to eq "/applications/#{@huy.id}"
        expect(@huy.pets).to include @snugglez
      end
    end
  end

  describe 'user story 6' do 
    describe 'Once a user selects pet(s) then they can add a reason for adopting' do
      it 'Reason for Adoption doesnt show until pets added' do 
        visit "/applications/#{@huy.id}"

        expect(page).to_not have_content "Reason for Adoption:"

        fill_in 'pet_name', with: "Snugglez"
        click_button "Search Pets"
        expect(current_path).to eq "/applications/#{@huy.id}"
        expect(page).to have_content "Snugglez"
        click_button "Adopt this Pet"

        expect(page).to have_content "Reason for Adoption:"
      end

      it 'Allows the user to input their reason and allows them to submit their app for pending' do 
        visit "/applications/#{@huy.id}"

        expect(page).to_not have_content "Reason for Adoption:"

        fill_in 'pet_name', with: "Snugglez"
        click_button "Search Pets"
        expect(current_path).to eq "/applications/#{@huy.id}"
        expect(page).to have_content "Snugglez"
        click_button "Adopt this Pet"
        fill_in "description", with: "Im so fresh"
        click_button "Submit Application for Review"

        expect(current_path).to eq "/applications/#{@huy.id}"
        expect(page).to have_content "Application Status: Pending"
        expect(page).to_not have_content "Search for Pets by Name:"
      end
    end
  end
 
  describe 'user story 7' do
    it 'when I visit the show page and havent added pets I cannot submit the application' do
      visit "/applications/#{@huy.id}"

      expect(page).to_not have_button "Submit Application for Review"

      fill_in 'pet_name', with: "Snugglez"
      click_button "Search Pets"
      expect(current_path).to eq "/applications/#{@huy.id}"
      expect(page).to have_content "Snugglez"
      click_button "Adopt this Pet"

      expect(page).to have_button "Submit Application for Review"

    end
  end
end