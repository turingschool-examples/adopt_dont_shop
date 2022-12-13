require 'rails_helper'

RSpec.describe 'the admin application show page' do
  before(:each) do
    @app1 = Application.create!(name: "Max", 
                                street_address: "Made up St", city: "Denver", 
                                state: "CO", 
                                zip_code: "80000", 
                                description: "Love mix breeds. Lots of energy to play with a dog", 
                                status: "Pending")
    @app2 = Application.create!(name: "Alastair", 
                                street_address: "Fictional St", 
                                city: "Golden", 
                                state: "CO", 
                                zip_code: "80001", 
                                description: "Love big dogs. Great mountain walks on doorstep", 
                                status: "Accepted")
    @app3 = Application.create!(name: "Chloe", 
                                street_address: "Fake Street", 
                                city: "Denver", 
                                state: "CO", 
                                zip_code: "80002", 
                                status: "In Progress")
    @shelter = Shelter.create!(name: 'Aurora shelter', 
                              city: 'Aurora, CO', 
                              foster_program: false, 
                              rank: 9)
    @pet1 = @app1.pets.create!(name: 'Noodle', 
                              age: 2, 
                              breed: 'Border Collie', 
                              adoptable: true, 
                              shelter_id: @shelter.id)
    @pet2 = @app1.pets.create!(name: 'Hercules', 
                              age: 2, 
                              breed: 'American Akita', 
                              adoptable: true, 
                              shelter_id: @shelter.id)
    @pet3 = @app2.pets.create!(name: 'Bumblebee', 
                              age: 1, 
                              breed: 'Welsh Corgi', 
                              adoptable: true,
                              shelter_id: @shelter.id)
  end
  
  it 'has a show page' do
    visit "admin/applications/#{@app1.id}"
    
    expect(page).to_not have_content(@app2.name)
    expect(page).to_not have_content(@pet3.name)
    
    expect(page).to have_content(@app1.name)
    expect(page).to have_content(@app1.street_address)
    expect(page).to have_content(@app1.city)
    expect(page).to have_content(@app1.state)
    expect(page).to have_content(@app1.zip_code)
    expect(page).to have_content(@app1.description)
    expect(page).to have_content(@app1.status)
    expect(page).to have_content(@pet1.name)
    expect(page).to have_content(@pet2.name)
  end
  
  it 'every pet listed has an approve button' do
    visit "admin/applications/#{@app1.id}"
    # save_and_open_page
    expect(page).to have_button("Approve")
    
  end
  # √ When I visit an admin application show page ('/admin/applications/:id')
  # For every pet that the application is for, I see a button to approve the application for that specific pet
  # When I click that button
  # Then I'm taken back to the admin application show page
  # And next to the pet that I approved, I do not see a button to approve this pet
  # And instead I see an indicator next to the pet that they have been approved
  
  xit 'THIS IS HERE TO OPEN DIFFERENT PAGES' do
    # visit "admin/applications/#{@app1.id}"
    visit "admin/applications/#{@app2.id}"
    visit "admin/applications/#{@app3.id}"
    # save_and_open_page
  end
end