require 'rails_helper'

RSpec.describe 'admin shelter page' do
  before(:each) do
    @shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter2 = Shelter.create(name: 'Doggy Shelter', city: 'Austin, TX', foster_program: false, rank: 4)

    @pet1 = @shelter1.pets.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true)
    @pet2 = @shelter2.pets.create(name: 'Toby', age: 3, breed: 'Great Dane', adoptable: true)

    @applicant1 = @pet1.applicants.create(name: 'Russell Rockwood', address: '1065 Walnut St', city: 'Bremerton', state: 'WA', zip: 98310)
  end

  it "has button to approve pet for adoption" do
      visit "/admin/applicants/#{@applicant1.id}"

      expect(page).to have_selector(:link_or_button, 'Approve')
  end

  it "indicates pet is approved for adoption" do
      visit "/admin/applicants/#{@applicant1.id}"
      click_link 'Approve'

      expect(page).to have_content('Approved')
  end

  # it "lists all shelters in reverse alphabetical" do
  #   visit '/admin/shelters'
  #
  #   expect(@shelter2.name).to appear_before(@shelter1.name)
  # end
  #
  # it "lists shelters with pending appications" do
  #   visit '/admin/shelters'
  #
  #   within '#pending' do
  #     expect(page).to have_content('Aurora shelter')
  #   end
  # end
end
