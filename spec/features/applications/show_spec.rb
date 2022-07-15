require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows the application and all it's attributes" do
    application = Application.create!(name: 'John Doe', street_address: '123 apple street', city: 'Denver', state: 'CA', zipcode: '90210', description: 'we love pets', status: 'in progress')
    shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

    PetApplication.create!(pet: pet, application: application)

    visit "/applications/#{application.id}"

    expect(page).to have_content('John Doe')
    expect(page).to have_content('123 apple street')
    expect(page).to have_content('Denver')
    expect(page).to have_content('CA')
    expect(page).to have_content('90210')
    expect(page).to have_content('we love pets')
    expect(page).to have_content('in progress')

    expect(page).to have_link('Scooby')
  end

  it "has a field to search and add a Pet to this Application" do
    application = Application.create!(name: 'John Doe', street_address: '123 apple street', city: 'Denver', state: 'CO', zipcode: '90210', description: 'we love pets', status: 'In Progress')
    shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

    PetApplication.create!(pet: pet, application: application)

    visit "/applications/#{application.id}"

    expect(page).to have_content('In Progress')

    within "#pet_search" do 
    expect(page).to have_content('Search for a Pet to Add to this Application')
    end 
  end

  it "show pet names that match the full name you put in" do
    application = Application.create!(name: 'John Doe', street_address: '123 apple street', city: 'Denver', state: 'CO', zipcode: '90210', description: 'we love pets', status: 'In Progress')
    shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    scooby = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    clifford = Pet.create!(name: 'Clifford', age: 1, breed: 'Red Dog', adoptable: true, shelter_id: shelter.id)
    rudolph = Pet.create!(name: 'Rudolph', age: 100, breed: 'Not Sure', adoptable: false, shelter_id: shelter.id)

    PetApplication.create!(pet: scooby, application: application)

    visit "/applications/#{application.id}"

    fill_in('Search for Pets by name:', with: "Scooby")
    
    click_button("Search")

    expect(current_path).to eq("/applications/#{application.id}")
    within "#searched_pets" do 
      expect(page).to have_content("Scooby")
      expect(page).to_not have_content("Clifford")
      expect(page).to_not have_content("Rudolph")
    end 
  end

  it "show pet names that contain a portion of what was searched for" do
    application = Application.create!(name: 'John Doe', street_address: '123 apple street', city: 'Denver', state: 'CO', zipcode: '90210', description: 'we love pets', status: 'In Progress')
    shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    scooby = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    clifford = Pet.create!(name: 'Clifford', age: 1, breed: 'Red Dog', adoptable: true, shelter_id: shelter.id)
    rudolph = Pet.create!(name: 'Rudolph', age: 100, breed: 'Not Sure', adoptable: false, shelter_id: shelter.id)

    PetApplication.create!(pet: scooby, application: application)

    visit "/applications/#{application.id}"

    fill_in('Search for Pets by name:', with: "ford")
    
    click_button("Search")

    expect(current_path).to eq("/applications/#{application.id}")
    within "#searched_pets" do 
      expect(page).to have_content("Clifford")
      expect(page).to_not have_content("Scooby")
      expect(page).to_not have_content("Rudolph")
    end 
  end

  it "has a button adopt this pet next to each pet after searching the name" do
    application = Application.create!(name: 'John Doe', street_address: '123 apple street', city: 'Denver', state: 'CO', zipcode: '90210', description: 'we love pets', status: 'In Progress')
    shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    scooby = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    clifford = Pet.create!(name: 'Clifford', age: 1, breed: 'Red Dog', adoptable: true, shelter_id: shelter.id)
    rudolph = Pet.create!(name: 'Rudolph', age: 100, breed: 'Not Sure', adoptable: false, shelter_id: shelter.id)
    fordie = Pet.create!(name: 'Fordie', age: 3, breed: 'Lab', adoptable: true, shelter_id: shelter.id)

    PetApplication.create!(pet: scooby, application: application)

    visit "/applications/#{application.id}"

    fill_in('Search for Pets by name:', with: "ford")
    
    click_button("Search")

    expect(current_path).to eq("/applications/#{application.id}")
    within "#searched_pets" do 
      expect(page).to have_button("Adopt this Pet")
    end 
  end

  it "adopt this pet button adds the pet to the application" do
    application = Application.create!(name: 'John Doe', street_address: '123 apple street', city: 'Denver', state: 'CO', zipcode: '90210', description: 'we love pets', status: 'In Progress')
    shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    scooby = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    clifford = Pet.create!(name: 'Clifford', age: 1, breed: 'Red Dog', adoptable: true, shelter_id: shelter.id)
    rudolph = Pet.create!(name: 'Rudolph', age: 100, breed: 'Not Sure', adoptable: false, shelter_id: shelter.id)
    fordie = Pet.create!(name: 'Fordie', age: 3, breed: 'Lab', adoptable: true, shelter_id: shelter.id)

    PetApplication.create!(pet: scooby, application: application)

    visit "/applications/#{application.id}"

    fill_in('Search for Pets by name:', with: "Cli")
    
    click_button("Search")

    click_button("Adopt this Pet")

    expect(current_path).to eq("/applications/#{application.id}")

    within "#pets_in_application" do 
      expect(page).to have_content("Clifford")
      expect(page).to_not have_content("Fordie")
    end 
  end

  it 'shows a submit section when pets are part of application' do
    application = Application.create!(name: 'John Doe', street_address: '123 apple street', city: 'Denver', state: 'CO', zipcode: '90210', description: 'we love pets', status: 'In Progress')
    shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    scooby = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

    PetApplication.create!(pet: scooby, application: application)

    visit "/applications/#{application.id}"

    expect(page).to have_button("Submit this Application")
  end

  it 'doesnt show a submit section without and pets in application'do
    application = Application.create!(name: 'John Doe', street_address: '123 apple street', city: 'Denver', state: 'CO', zipcode: '90210', description: 'we love pets', status: 'In Progress')
    shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)

    visit "/applications/#{application.id}"

    expect(page).to_not have_button("Submit this Application")
  end

  it 'when submitted the Application status is pending and I cant add more pets' do
    application = Application.create!(name: 'John Doe', street_address: '123 apple street', city: 'Denver', state: 'CO', zipcode: '90210', description: 'Description needed', status: 'In Progress')
    shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    scooby = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    clifford = Pet.create!(name: 'Clifford', age: 1, breed: 'Red Dog', adoptable: true, shelter_id: shelter.id)

    PetApplication.create!(pet: scooby, application: application)
    
    visit "/applications/#{application.id}"
    
    fill_in('description', with: "We love pets")
    click_button("Submit this Application")

    expect(current_path).to eq("/applications/#{application.id}")
    expect(page).to have_content("Pending")
    expect(page).to have_content("Scooby")
    expect(page).to_not have_content("Clifford")
  end  
end