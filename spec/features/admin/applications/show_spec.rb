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
  
  it 'exists and shows application information' do
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

    expect(page).to have_button("Approve #{@pet1.name}")
    expect(page).to have_button("Approve #{@pet2.name}")
  end
  
  it 'clicking the approve button changes the pet status' do
    visit "admin/applications/#{@app1.id}"
    click_on "Approve #{@pet1.name}"
    
    expect(page).to have_content("Approved")
    expect(current_path).to eq ("/admin/applications/#{@app1.id}")
  end
  
  it 'every pet listed has a reject button' do
    visit "admin/applications/#{@app1.id}"

    expect(page).to have_button("Reject #{@pet1.name}")
    expect(page).to have_button("Reject #{@pet2.name}")
  end
  
  it 'clicking the reject button changes the pet status' do
    visit "admin/applications/#{@app1.id}"
    click_on "Reject #{@pet1.name}"
    
    expect(page).to have_content("Rejected")
    expect(current_path).to eq ("/admin/applications/#{@app1.id}")
  end
  
  describe 'User Story 14' do
    before(:each) do
      visit "applications/#{@app3.id}"
      fill_in 'Add a Pet to this Application', with: "#{@pet1.name}"
      click_button 'Search Pets'
      click_button 'Adopt this pet'
      fill_in 'Why I would make a good owner:', with: "Big yard, small child in need of herding."
      click_button('Submit Application')
    end
    
    it 'more than one application can have the same pet' do
      visit "admin/applications/#{@app3.id}"
      expect(page).to have_button('Approve Noodle')
      expect(page).to have_button('Reject Noodle')
      
      visit "admin/applications/#{@app1.id}"
      expect(page).to have_button('Approve Noodle')
      expect(page).to have_button('Reject Noodle')
    end
    
    it 'will not change the status of a pet on another application' do
      visit "admin/applications/#{@app3.id}"
      click_on "Approve #{@pet1.name}"
      
      visit "admin/applications/#{@app1.id}"
      expect(page).to have_content('Noodle')
      expect(page).to have_button('Approve Noodle')
      expect(page).to have_button('Reject Noodle')
    end
  end
end