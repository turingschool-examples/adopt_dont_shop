require 'rails_helper'

RSpec.describe 'the admin application show page' do
  before(:each) do
    @app1 = Application.create!(name: "Max", 
                                street_address: "Made up St", city: "Denver", 
                                state: "CO", 
                                zip_code: "80000", 
                                description: "Love mix breeds. Lots of energy to play with a dog", 
                                status: "In Progress")
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
  end
  
  it 'has a show page' do
    visit "admin/applications/#{@app1.id}"
    save_and_open_page
    # When I visit an admin application show page ('/admin/applications/:id')
    # For every pet that the application is for, I see a button to approve the application for that specific pet
    # When I click that button
    # Then I'm taken back to the admin application show page
    # And next to the pet that I approved, I do not see a button to approve this pet
    # And instead I see an indicator next to the pet that they have been approved
  end
end