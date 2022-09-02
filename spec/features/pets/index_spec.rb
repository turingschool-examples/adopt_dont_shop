require 'rails_helper'

RSpec.describe 'the pets index' do
  it 'lists all the pets with their attributes' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    visit "/pets"

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_1.breed)
    expect(page).to have_content(pet_1.age)
    expect(page).to have_content(shelter.name)

    expect(page).to have_content(pet_2.name)
    expect(page).to have_content(pet_2.breed)
    expect(page).to have_content(pet_2.age)
    expect(page).to have_content(shelter.name)
  end

  it 'only lists adoptable pets' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: false, age: 2, breed: 'saint bernard', name: 'Beethoven', shelter_id: shelter.id)

    visit "/pets"

    expect(page).to_not have_content(pet_3.name)
  end

  it 'displays a link to edit each pet' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    visit '/pets'

    expect(page).to have_content("Edit #{pet_1.name}")
    expect(page).to have_content("Edit #{pet_2.name}")

    click_link("Edit #{pet_1.name}")

    expect(page).to have_current_path("/pets/#{pet_1.id}/edit")
  end

  it 'displays a link to delete each pet' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    visit '/pets'

    expect(page).to have_content("Delete #{pet_1.name}")
    expect(page).to have_content("Delete #{pet_2.name}")

    click_link("Delete #{pet_1.name}")

    expect(page).to have_current_path("/pets")
    expect(page).to_not have_content(pet_1.name)
  end

  it 'has a text box to filter results by keyword' do
    visit "/pets"
    expect(page).to have_button("Search")
  end

  it 'lists partial matches as search results' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
    pet_3 = Pet.create(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)

    visit "/pets"

    fill_in 'Search', with: "Ba"
    click_on("Search")

    expect(page).to have_content(pet_1.name)
    expect(page).to have_content(pet_2.name)
    expect(page).to_not have_content(pet_3.name)
  end

  describe 'Starting an Application' do
    before :each do
      @app1 = Application.create!(fname: 'John', lname: 'Smithson', street_address: '12324 Turing Blvd.', city: 'Dtown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasons', status: "In Progress" )

      @shelter1 = Shelter.create!(foster_program: true, name: 'Happy Shelter', city: 'Dmetro', rank: 3 )

      @pet1 = @shelter1.pets.create!(adoptable: true, age: 5, breed: 'dog', name: 'Roofus')
      @pet2 = @shelter1.pets.create!(adoptable: true, age: 12, breed: 'cat', name: 'Nacho')
      @pet3 = @shelter1.pets.create!(adoptable: false, age: 8, breed: 'bird', name: 'Big')

      @shelter2 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

      @pet4 = @shelter2.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
      @pet5 = @shelter2.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster')

      @app1.pets << @pet1
    end
    
    describe 'when I visit the pet index page' do
      describe 'I see a link to Start an Application' do
        it 'has a link to Start an Application' do 
          visit "/pets/#{@pet2.id}"

          expect(page).to have_link("Start Adoption Applcation")
        end
        xit 'when link is clicked, route to new application page' do
          visit "/pets/#{@pet2.id}"
          click_link "Start Adoption Application"

          expect(current_path).to eq("/applications/#{applications.id}")
        end
        xit 'form is present to fill in and a submit button (another test same as this in spec/features/applications/show_spec.rb)' do
          visit "/pets/#{@pet2.id}"
          click_link "Start Adoption Application"

          expect(page).to have_content("First Name")
          expect(page).to have_content("Last Name")
          expect(page).to have_content("Street Address")
          expect(page).to have_content("City")
          expect(page).to have_content("State")
          expect(page).to have_content("Zip Code")
          expect(page).to have_button("Submit")
        end
        xit "Submit takes user to application's show page (another test same as this in spec/features/applications/show_spec.rb)" do
          visit "/pets/#{@pet2.id}"

          click_link "Start Adoption Application"

          fill_in 'First Name', with: 'Bruce'
          fill_in 'Last Name', with: 'Willis'
          fill_in 'Street Address', with: '9876 Miller Dr.'
          fill_in 'City', with: 'Whoville'
          fill_in 'State', with: 'KS'
          fill_in 'Zip Code', with: '54637'

          click_button 'Submit'

          expect(current_path).to eq("/applications/#{applications.id}")
        end
        xit 'sees Name, address, and good home argument (another test same as this in spec/features/applications/show_spec.rb)' do
          visit "/pets/#{@pet2.id}"

          click_link "Start Adoption Application"

          fill_in 'First Name', with: 'Bruce'
          fill_in 'Last Name', with: 'Willis'
          fill_in 'Street Address', with: '9876 Miller Dr.'
          fill_in 'City', with: 'Whoville'
          fill_in 'State', with: 'KS'
          fill_in 'Zip Code', with: '54637'

          click_button 'Submit'

          expect(page).to have_content("Name: Bruce Willis")
          expect(page).to have_content("Address: 9876 Miller Dr. Whoville, KS 54637")
          expect(page).to have_content("Good home argument")
          expect(page).to have_content("Application Status: In Progress")
        end
      end
    end
  end
end
