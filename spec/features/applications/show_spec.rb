require 'rails_helper'

RSpec.describe 'the application show' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    @application = Application.create!(name: 'David',street: '1023 Makeup',city: 'Chicago', state: 'IL', zip: '60657', description: 'greate person', status: 'pending')
    @pet_application = ApplicationPet.create!(pet_id: @pet_1.id, application_id: @application.id)
  end

  it 'shows all of the applicants' do


    visit "/applications/#{@application.id}"

    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.street)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.state)
    expect(page).to have_content(@application.zip)
    expect(page).to have_content(@application.description)
    expect(page).to have_content(@application.status)

    expect(page).to have_link("#{@pet_1.name}")
    click_link "#{@pet_1.name}"
    expect(current_path).to eq("/pets/#{@pet_1.id}")

  end

  describe 'visits an applications show page' do
    describe 'has a section to add a pet' do
      it 'can search for a pet by name and submit' do

        visit "/applications/#{@application.id}"



        expect(page).to have_button("Submit")

        fill_in 'Search', with: "Clawdia"
        click_on("Submit")

        expect(current_path).to eq("/applications/#{@application.id}")

        expect(page).to have_content(@pet_2.name)
        expect(page).to_not have_content(@pet_3.name)
      end

      it 'has a button next to a pet name to add to application' do

        visit "/applications/#{@application.id}"
        fill_in 'Search', with: "Clawdia"
        click_on("Submit")
        expect(page).to have_content(@pet_2.name)

        expect(page).to have_button("Adopt this Pet")
        click_on("Adopt this Pet")

        expect(current_path).to eq("/applications/#{@application.id}")

      end
    end
  end

end
