require 'rails_helper'

RSpec.describe 'the applications show page' do
  before do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)

    @application = Application.create(
      name: 'Sherman',
      address: '123 Main St', city: 'Longmont', state: 'CO', zipcode: '80501',
      description: ''
    )
    PetApplication.create!(pet_id: @pet_1.id, application_id: @application.id)
    PetApplication.create!(pet_id: @pet_2.id, application_id: @application.id)

    visit "/applications/#{@application.id}"
  end

  it 'shows the attributes of the application' do
    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.address)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.state)
    expect(page).to have_content(@application.zipcode)
    expect(page).to have_content(@application.status)
  end

  it 'pet names has redirect link' do
    expect(page).to have_link(@pet_1.name.to_s, href: "/pets/#{@pet_1.id}")

    click_link @pet_1.name.to_s

    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end

  describe 'search in applicatioins' do
    before do
      @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter.pets.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true,
                                    shelter_id: @shelter.id)
      @pet_2 = @shelter.pets.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster',
                                    shelter_id: @shelter.id)
      @pet3 = @shelter.pets.create!(adoptable: true, age: 7, breed: 'Golden Retriever', name: 'Carter')
      @application1 = Application.create!(name: 'Chris', address: '123 Main St', city: 'Hometown', state: 'CO',
                                          zipcode: '80504')
      visit "/applications/#{@application1.id}"
    end

    it 'Unsubmitted applications have a search box to select pets by name and when adopt button clicked, pet is attached to application' do
      fill_in(:pet_name, with: 'Carter')
      click_button('Search')
      expect(current_path).to eq("/applications/#{@application1.id}")
      within ".pet-#{@pet3.id}" do
        expect(page).to have_content(@pet3.name)
        click_button('Adopt')
        expect(current_path).to eq("/applications/#{@application1.id}")
      end

      within '.requested_pets' do
        expect(page).to have_content(@pet3.name)
      end
    end

    it 'shows a section to input on why applicant would be a good owner' do
      expect(page).to_not have_content('Describe why you make a good owner for these pets:')
      fill_in(:pet_name, with: @pet3.name.to_s)

      click_button 'Search'
      click_button 'Adopt'

      expect(page).to have_content('Describe why you make a good owner for these pets:')
      fill_in('Description', with: 'Dogs are amazing')

      click_button 'Submit Application'

      expect(current_path).to eq("/applications/#{@application1.id}")
      expect(page).to have_content('Pending')
      expect(page).to_not have_content('Accepted')
      expect(page).to_not have_content('Search')
      expect(page).to_not have_content('In Progress')
      expect(page).to_not have_content('Rejected')
    end

    it '#search allows for partial matches' do
      fill_in(:pet_name, with: 'ob')
      click_button 'Search'

      within ".pet-#{@pet_2.id}" do
        expect(page).to have_content(@pet_2.name)
      end

      within ".pet-#{@pet_1.id}" do
        expect(page).to have_content(@pet_1.name)
      end
    end
  end
end
