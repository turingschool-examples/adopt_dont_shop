require 'rails_helper'

RSpec.describe 'admin application show page' do
  before(:each) do
    #shelters
    @shelter_1 = Shelter.create(name: "Boulder Humane Society", city: "Boulder, CO", rank: 1, foster_program: "true")
    @shelter_2 = Shelter.create(name: "Denver Humane Society", city: "Denver, CO", rank: 2, foster_program: "false")

    #pets
    @pet1 = @shelter_1.pets.create(name: "Gertie", breed: "Border Collie", adoptable: true, age: 1)
    @pet2 = @shelter_1.pets.create(name: "Millie", breed: "Labrador Retriever", adoptable: true, age: 3)
    @pet3 = @shelter_1.pets.create(name: "Harper", breed: "Lab/Shar Pei/Chow mix", adoptable: false, age: 1)
    @pet4 = @shelter_1.pets.create(name: "fluff", breed: "Pit Pull", adoptable: true, age: 4)
    @pet5 = @shelter_2.pets.create(name: "Mr. Fluff", breed: "Chihuahua", adoptable: true, age: 2)

    #applications
    @app1 = Application.create(name: 'Alice Pieszecki', street: '407 Race St', city: 'Denver', state: 'CO', zip_code: 80305, description: 'A reason', status: 'Pending')
    @app2 = Application.create(name: 'Bette Porter', street: '777 Corona St', city: 'Denver', state: 'CO', zip_code: 80221, description: 'B reason', status: 'Pending')
    @app3 = Application.create(name: 'Shane McCutchen', street: '1234 Pine Ave', city: 'Arvada', state: 'CO', zip_code: 80218, description: 'C reason', status: 'Pending')
    @app4 = Application.create(name: 'Jenny Schecter', street: '2043 21st St', city: 'Denver', state: 'CO', zip_code: 80218, description: 'D reason', status: 'Rejected')
    @app5 = Application.create(name: 'Tina Kennard', street: '12 Colorado Blvd', city: 'Denver', state: 'CO', zip_code: 80210, description: 'E reason', status: 'In Progress')

    #pet application
    PetApplication.create!(application: @app1, pet: @pet1)
    PetApplication.create!(application: @app2, pet: @pet2)
    PetApplication.create!(application: @app3, pet: @pet1)
    PetApplication.create!(application: @app3, pet: @pet3)
    PetApplication.create!(application: @app4, pet: @pet4)
  end

  it 'can approve an application for a pet' do
  # Approving a Pet for Adoption
  #
  # As a visitor
  # When I visit an admin application show page ('/admin/ applications/:id')
  # For every pet that the application is for, I see a  button to approve the application for that specific pet
  # When I click that button
  # Then I'm taken back to the admin application show page
  # And next to the pet that I approved, I do not see a button to approve this pet
  # And instead I see an indicator next to the pet that they have been approved

  visit "/admin/applications/#{@app3.id}"

  expect(page).to have_content("Admin Application Page")
  expect(page).to have_content("Applicant: #{@app3.name}")
  expect(page).to have_content(@pet1.name)
  expect(page).to have_content(@pet3.name)
  expect(page).to have_button("Approve")
  expect(page).to have_css("#pet_#{@pet1.id}")
  expect(page).to have_css("#pet_#{@pet3.id}")

  within("#pet_#{@pet1.id}") do
    click_button("Approve")

    expect(current_path).to eq("/admin/applications/#{@app3.id}")
    expect(page).to_not have_button("Approve")
    expect(page).to have_content("Pet application has been approved!")
  end

  within("#pet_#{@pet3.id}") do
    expect(page).to have_button("Approve")
    expect(page).to_not have_content("Pet application has been approved!")
  end

  end

  it 'can reject an application for a pet' do
    # Rejecting a Pet for Adoption
    #
    # As a visitor
    # When I visit an admin application show page ('/admin/applications/:id')
    # For every pet that the application is for, I see a button to reject the application for that specific pet
    # When I click that button
    # Then I'm taken back to the admin application show page
    # And next to the pet that I rejected, I do not see a button to approve or reject this pet
    # And instead I see an indicator next to the pet that they have been rejected
  visit "/admin/applications/#{@app3.id}"

  expect(page).to have_content("Admin Application Page")
  expect(page).to have_content("Applicant: #{@app3.name}")
  expect(page).to have_content(@pet1.name)
  expect(page).to have_content(@pet3.name)
  expect(page).to have_button("Reject")

  within("#pet_#{@pet1.id}") do
    click_button("Reject")

    expect(current_path).to eq("/admin/applications/#{@app3.id}")
    expect(page).to_not have_button("Approve")
    expect(page).to_not have_button("Reject")
    expect(page).to have_content("Pet application has been rejected!")
  end

  within("#pet_#{@pet3.id}") do
    expect(page).to have_button("Approve")
    expect(page).to have_button("Reject")
    expect(page).to_not have_content("Pet application has been rejected!")
  end

  end
end
