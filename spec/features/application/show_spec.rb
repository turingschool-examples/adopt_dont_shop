require 'rails_helper'

RSpec.describe "#show" do
  describe 'user story 1' do
    describe 'When user visits application show page' do
      it 'displays the attributes of the applicant' do
        @pound = Shelter.create!(foster_program: true, name: 'The Pound', city: "Denver", rank: 1)
        @snugglez = @pound.pets.create!(adoptable: true, age: 2, breed: "Tabby Cat", name: 'Snugglez')
        @huy = Application.create!(applicant_name: "Huy Phan", app_street: "123 Park Ave", app_city: "Denver", app_state: "CO", app_zip_code: "80205", description: "Im super cool and stuffy" )
        ApplicationPet.create!(pet: @snugglez, application: @huy)

        visit "/applications/#{@huy.id}"

        expect(page).to have_content "#{@huy.applicant_name}'s Application for Pet Adoption"
        expect(page).to have_content "#{@huy.app_street}"
        expect(page).to have_content "#{@huy.description}"
        expect(page).to have_content "Applicant's Desired Pets: #{@snugglez.name}"
        expect(page).to have_content "Application Status: #{@huy.status}"
      end
    end
  end
end