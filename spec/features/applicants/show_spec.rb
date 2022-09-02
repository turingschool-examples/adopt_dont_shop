require 'rails_helper'

RSpec.describe 'applicant show page' do

  # User Story 2
  # As a visitor
  # When I visit an applications show page
  # Then I can see the following:

  # Name of the Applicant
  # Full Address of the Applicant including street address, city, state, and zip code
  # Description of why the applicant says they'd be a good home for this pet(s)
  # names of all pets that this application is for (all names of pets should be links to their show page)
  # The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

  describe 'hen I visit an applications show page' do
    it 'I see Name of the Applicant' do
      shelter = Shelter.create!(foster_program: true, name: "Pet Friends of Kansas", city: "Topeka", rank: 8)
      dog1 = shelter.pets.create!(adoptable: true, age: 5, breed: 'Poodle', name: 'Fiona')
      dog2 = shelter.pets.create!(adoptable: true, age: 2, breed: 'Terrier', name: 'Rosco')
      cat1 = shelter.pets.create!(adoptable: true, age: 7, breed: 'Persian', name: 'SlimJim')
      cat2 = shelter.pets.create!(adoptable: true, age: 1, breed: 'Tabby', name: 'Catmobile')
      app1 = Applicant.create!(first_name: 'Sally', last_name: 'Field', address: '115 Oakview Avenue, Topeka, Kansas, 65119', description: 'I dislike every bird, therefore I require many cats.', status: 'pending')
      app2 = Applicant.create!(first_name: 'Burt', last_name: 'Reynolds', address: '400 Pine Drive, Bend, Oregon, 91123', description: 'I find tiny barking dogs to be extremely soothing and it is important to me that my neighbors know that.', status: 'pending')

      app1.pets << cat1
      app1.pets << cat2
      app2.pets << dog1
      app2.pets << dog2

      visit "/applicants/#{app1.id}"
      save_and_open_page
    end
  end
end