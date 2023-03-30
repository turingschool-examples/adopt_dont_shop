require 'rails_helper'

RSpec.describe 'applications/:id', type: :feature do
  let(:applicant) { Applicant.create!(name: "John Doe", address: "123 Main St, Anytown USA 12345", description: "I love dogs and have a big yard for them to run in.", status: "Pending") }
  let(:pet1) { Pet.create!(name: "Fido", age: 2, breed: "Lab", adoptable: true) }
  let(:pet2) { Pet.create!(name: "Spot", age: 3, breed: "Pitbull", adoptable: true) }
  applicant.pets << pet1
  applicant.pets << pet2

  describe 'As a visitor, when I visit an applications show page' do
    it 'I see an applicant and their attributes' do
      visit "/applications/#{applicant.id}"

      expect(page).to have_content(applicant.name)
      expect(page).to have_content(applicant.address)
      expect(page).to have_content(applicant.description)
      expect(page).to have_content(applicant.status)

      expect(page).to have_link(pet1.name, href: "/pets/#{pet1.id}")
      expect(page).to have_link(pet2.name, href: "/pets/#{pet2.id}")
    end
  end
end