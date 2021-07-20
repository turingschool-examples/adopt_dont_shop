require 'rails_helper'

RSpec.describe 'Admin Applications Show' do
  before(:each) do
    PetApplicant.destroy_all
    Pet.destroy_all
    Applicant.destroy_all
    Shelter.destroy_all

    @furry = Shelter.create!(name:'Furrry Shelter', foster_program: true, city: 'New Orleans', rank: 5)

    @bruce = @furry.pets.create!(name: 'Bruce', age: 3, adoptable: true, breed: 'black lab')
    @lana = @furry.pets.create!(name: 'Lana', age: 1, adoptable: true, breed: 'short-haired')
    @doc = @furry.pets.create!(name: 'Doc', age: 8, adoptable: true, breed: 'schnauzer')
    @doctor = @furry.pets.create!(name: 'Doctor', age: 9, adoptable: true, breed: 'pomeranian')

    @application1 = Applicant.create!(name: 'Carina', street_address: '455 Cool Street', city: 'Portland', state: 'OR', zip_code: 23392, status: 'Pending')

    @application2 = Applicant.create!(name: 'Evan', street_address: '1234 Sparky Lane', city: 'Portland', state: 'OR', zip_code: 23392, home_description: 'I like playing and throwing ball with dogs', status: 'Pending')

    @application1.pets << [@lana, @doc]
    @application2.pets << [@lana, @doc]
  end

  describe 'visitor' do
    it 'can approve pets on application' do
      visit "/admin/applications/#{@application1.id}"

      expect(page).to have_content(@lana.name)
      expect(page).to have_content(@doc.name)

      within(:css, "##{@lana.id}") do
        click_on('Approve')
      end

      expect(current_path).to eq("/admin/applications/#{@application1.id}")

      within(:css, "##{@lana.id}") do
        expect(page).to have_content('Approved')
      end

      within(:css, "##{@doc.id}") do
        find_button('Approve').visible?
      end
    end

    it 'can reject pets on application' do
      visit "/admin/applications/#{@application1.id}"

      expect(page).to have_content(@lana.name)
      expect(page).to have_content(@doc.name)

      within(:css, "##{@lana.id}") do
        click_on('Reject')
      end

      expect(current_path).to eq("/admin/applications/#{@application1.id}")

      within(:css, "##{@lana.id}") do
        expect(page).to have_content('Rejected')
        expect(page).to_not have_content('Approve')
      end

      within(:css, "##{@doc.id}") do
        find_button('Reject').visible?
        find_button('Approve').visible?
      end
    end

    it 'pets on other applications are not affected' do
      visit "/admin/applications/#{@application1.id}"

      expect(page).to have_content(@lana.name)
      expect(page).to have_content(@doc.name)

      within(:css, "##{@lana.id}") do
        click_on('Reject')
      end

      within(:css, "##{@doc.id}") do
        click_on('Approve')
      end

      visit "/admin/applications/#{@application2.id}"

      within(:css, "##{@lana.id}") do
        find_button('Reject').visible?
        find_button('Approve').visible?
      end

      within(:css, "##{@doc.id}") do
        find_button('Reject').visible?
        find_button('Approve').visible?
      end
    end

    it 'maintains rejection/approval status on same application' do
      visit "/admin/applications/#{@application1.id}"

      within(:css, "##{@lana.id}") do
        click_on('Approve')
      end

      expect(current_path).to eq("/admin/applications/#{@application1.id}")

      within(:css, "##{@doc.id}") do
        click_on('Reject')
      end

      expect(current_path).to eq("/admin/applications/#{@application1.id}")

      within(:css, "##{@lana.id}") do
        expect(page).to have_content('Approved')
      end

      within(:css, "##{@doc.id}") do
        expect(page).to have_content('Rejected')
      end

      visit "/admin/applications/#{@application1.id}"

      within(:css, "##{@lana.id}") do
        expect(page).to have_content('Approved')
      end

      within(:css, "##{@doc.id}") do
        expect(page).to have_content('Rejected')
      end
    end
  end
end
