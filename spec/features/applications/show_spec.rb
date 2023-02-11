require 'rails_helper'

describe 'app show page' do
#   1. app Show Page
# As a visitor
# When I visit an apps show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this app is for (all names of pets should be links to their show page)
# - The app's status, either "In Progress", "Pending", "Accepted", or "Rejected"
  describe 'app details' do
    before(:each) do 
      @app = Application.create!( name: 'John Smith', 
                                          address: '123 Fake Street',
                                          city: 'Springfield', 
                                          state: 'IL', 
                                          zipcode: 12345,
                                          description: 'I like dogs.',
                                          status: 'In Progress'
                                        )
    end
    
    it 'has the name' do
      visit "/applications/#{@app.id}"
      expect(page).to have_content(@app.name)
    end
    it 'has the address' do
      visit "/applications/#{@app.id}"
      expect(page).to have_content(@app.address)
      expect(page).to have_content(@app.city)
      expect(page).to have_content(@app.state)
      expect(page).to have_content(@app.zipcode)
    end
    it 'has the description' do
      visit "/applications/#{@app.id}"
      expect(page).to have_content('I like dogs.')
    end
    it 'has all pets names' do
      shelter = Shelter.create!(
                                foster_program: true, 
                                name: 'Dog house', 
                                city: 'Springfield', 
                                rank: 1
                              )
      fido = shelter.pets.create!( 
                          adoptable: true,
                          age: 1,
                          breed: 'weiner',
                          name: 'Fido',
                        )
      santa = shelter.pets.create!( 
                          adoptable: true,
                          age: 1,
                          breed: 'whippet',
                          name: 'Santa\'s Little Helper',
                          )
      petapp1 = PetApplication.create!(application_id: @app.id, pet_id: fido.id)
      petapp2 = PetApplication.create!(application_id: @app.id, pet_id: santa.id)
      visit "/applications/#{@app.id}"
      expect(page).to have_content(santa.name)
      expect(page).to have_content(fido.name)

    end
    it 'pet names are links to the pet show page' do

    end
    it 'has app\'s status' do
      visit "/applications/#{@app.id}"
      expect(page).to have_content(@app.status)

    end
  end

end