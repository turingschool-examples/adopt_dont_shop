require 'rails_helper'

RSpec.describe 'the admin application show page' do
  let(:shelter)     { Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)}
  let(:fluffy)     { shelter.pets.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Fluffy')}
  let(:buffy)      { shelter.pets.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Buffy')}
  let(:elle)       { shelter.pets.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle') }
  let(:application) { Application.create(
    name:        'CatMan',
    address:     '123 Main Street',
    city:        'Denver',
    state:       'CO',
    zip:         '80204',
    description: 'I WANT ALL THE CATS!'
  ) }

  describe 'approving pet applications' do
    it 'each pet on an application has a button to approve' do
      application.pets << fluffy
      visit "/admin/applications/#{application.id}"

      expect(page).to have_button 'Approve'
    end

    it 'clicking that button reloads the page with the pet approved' do
      application.pets << fluffy
      visit "/admin/applications/#{application.id}"
      click_on 'Approve'

      expect(current_path).to eq "/admin/applications/#{application.id}"
      expect(page).to have_content ': Approved'
      expect(page).to_not have_button 'Approve'
    end
  end

  describe 'rejecting pet applications' do
    it 'each pet on an application has a button to reject' do
      application.pets << fluffy
      visit "/admin/applications/#{application.id}"

      expect(page).to have_button 'Reject'
    end

    it 'clicking that button reloads the page with the pet rejected' do
      application.pets << fluffy
      visit "/admin/applications/#{application.id}"
      click_on 'Reject'

      expect(current_path).to eq "/admin/applications/#{application.id}"
      expect(page).to have_content 'Rejected'
      expect(page).to_not have_button 'Reject'
    end
  end

  describe 'other applications for the same pet' do
    let(:application2) { Application.create(
      name:        'RatMan',
      address:     '124 Main Street',
      city:        'Denver',
      state:       'CO',
      zip:         '80204',
      description: 'I need some cats for my rats!'
    ) }

    it 'pets can be approved or rejected despite approvals in another application' do
      application.pets << fluffy
      application.pets << buffy
      application2.pets << fluffy
      visit "/admin/applications/#{application.id}"

      within "div#pet-#{fluffy.id}" do
        click_on 'Approve'

        expect(page).to_not have_button 'Approve'
        expect(page).to_not have_button 'Reject'
      end

      visit "/admin/applications/#{application2.id}"

      within "div#pet-#{fluffy.id}" do
        expect(page).to have_button 'Approve'
        expect(page).to have_button 'Reject'
      end
    end

    it 'pets cannot be approved or rejected if they are on another application that has been fully approved' do
      application.pets << fluffy
      application2.pets << fluffy
      visit "/admin/applications/#{application.id}"
      click_on 'Approve'

      expect(page).to_not have_button 'Approve'
      expect(page).to_not have_button 'Reject'

      visit "/admin/applications/#{application2.id}"

      expect(page).to_not have_button 'Approve'
      expect(page).to_not have_button 'Reject'
      expect(page).to have_content 'Sorry, this pet has already been approved for adoption!'
    end
  end

  describe 'when all pets on an application have been approved' do
    it "the application's status changes to 'Approved'" do
      application.pets << fluffy
      visit "/admin/applications/#{application.id}"
      click_on 'Approve'

      expect(page).to have_content 'Application Status: Approved'
    end

    it 'all of the applications pets are no longer adoptable' do
      application.pets << fluffy
      visit "/pets/#{fluffy.id}"

      expect(page).to have_content 'true'

      visit "/admin/applications/#{application.id}"
      click_on 'Approve'
      visit "/pets/#{fluffy.id}"

      expect(page).to have_content 'false'
    end
  end

  describe 'when one or more pets on an application have been rejected' do
    it "the application's status changes to 'Rejected'" do
      application.pets << fluffy
      visit "/admin/applications/#{application.id}"
      click_on 'Reject'

      expect(page).to have_content 'Application Status: Rejected'
    end
  end
end
