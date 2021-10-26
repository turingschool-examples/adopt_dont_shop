require 'rails_helper'

RSpec.describe 'pet application show' do
  it 'shows the applicant details' do
    app = PetApplication.create!(name: 'Liam', street: '155 Main Street', city: 'Phoenix', state: 'AZ', zip: 85_222,
                                 reason: 'Pet friendly, loving home looking for a companion')

    visit "/applications/#{app.id}"

    expect(page).to have_content(app.name)
    expect(page).to have_content(app.street)
    expect(page).to have_content(app.city)
    expect(page).to have_content(app.state)
    expect(page).to have_content(app.zip)
    expect(page).to have_content(app.reason)
  end

  describe 'pet information' do
    before(:each) do
      @app = PetApplication.create!(name: 'Liam', street: '155 Main Street', city: 'Phoenix', state: 'AZ', zip: 85_222,
                                    reason: 'Pet friendly, loving home looking for a companion')

      shelter = Shelter.create!(foster_program: true, name: 'Phoenix Pet Friends', city: 'Phoenix, AZ', rank: 2)

      @cat = @app.pets.create!(adoptable: true, age: 8, breed: 'Bombay', name: 'Moxie', shelter_id: shelter.id)
      @dog = @app.pets.create!(adoptable: true, age: 4, breed: 'Mutt', name: 'Daisy', shelter_id: shelter.id)
    end

    it 'shows pets tied to application' do
      visit "/applications/#{@app.id}"

      expect(page).to have_content(@cat.name)
      expect(page).to have_content(@dog.name)
    end

    it 'has links in pet names' do
      visit "/applications/#{@app.id}"

      click_on 'Moxie'

      expect(page).to have_current_path("/pets/#{@cat.id}")
    end
  end

  it 'shows application status' do
    app = PetApplication.create!(name: 'Liam', street: '155 Main Street', city: 'Phoenix', state: 'AZ', zip: 85_222,
                                 reason: 'Pet friendly, loving home looking for a companion')

    visit "/applications/#{app.id}"

    expect(page).to have_content("Application Status: #{app.status}")
  end
end
