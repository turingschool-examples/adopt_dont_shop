require 'rails_helper'

describe 'Application Show Page' do 
  describe 'When I visit an applications show page' do
    let!(:shelter) {Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)}

    let!(:app_1) {Application.create(name: 'Jonah Hill', street_address: '65 High St', city: 'New York', state: 'NY', zip: 28938, description: 'Animals love me!', status: 'In Progress')}
    let!(:pet_1) {app_1.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)}
    let!(:pet_2) {app_1.pets.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)}
    let!(:pet_3) {app_1.pets.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)}

    it 'shows name of the applicant' do
      visit "/applications/#{app_1.id}"

      expect(page).to have_content(app_1.name)
    end

    it 'shows Full Address of the Applicant including street address, city, state, and zip code' do
      visit "/applications/#{app_1.id}"

      expect(page).to have_content(app_1.street_address)
      expect(page).to have_content(app_1.city)
      expect(page).to have_content(app_1.state)
      expect(page).to have_content(app_1.zip)
    end

    it "shows Description of why the applicant says they'd be a good home for this pet(s)" do
      visit "/applications/#{app_1.id}"

      expect(page).to have_content(app_1.description)
    end

    it "shows names of all pets that this application is for" do
      visit "/applications/#{app_1.id}"

      expect(page).to have_content('Lucille Bald')
      expect(page).to have_content('Lobster')
      expect(page).to have_content('Beethoven')
    end

    it "all names of pets should be links to their show page" do
      visit "/applications/#{app_1.id}"

      expect(page).to have_link('Lucille Bald')
      expect(page).to have_link('Lobster')
      expect(page).to have_link('Beethoven')

      click_link 'Lucille Bald'

      expect(page.current_path).to eq("/pets/#{pet_1.id}")

    end

    it "The Application's status, either 'In Progress', 'Pending', 'Accepted', or 'Rejected'" do
      visit "/applications/#{app_1.id}"

      expect(page).to have_content('In Progress')

      save_and_open_page
    end

  end
end