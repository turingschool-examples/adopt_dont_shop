require 'rails_helper'

describe 'admin applications show' do
  before(:each) do
    @app = Application.create!(name: 'John Smith',
                               address: '123 Fake Street',
                               city: 'Springfield',
                               state: 'IL',
                               zipcode: 12_345,
                               description: 'I like dogs.',
                               status: 'Pending')

    @shelter = Shelter.create!(
      foster_program: true,
      name: 'Dog house',
      city: 'Springfield',
      rank: 1
    )
    @fido = @shelter.pets.create!(
      adoptable: true,
      age: 1,
      breed: 'weiner',
      name: 'Fido'
    )
    @santa = @shelter.pets.create!(
      adoptable: true,
      age: 1,
      breed: 'whippet',
      name: 'Santa\'s Little Helper'
    )
    petapp1 = PetApplication.create!(application_id: @app.id, pet_id: @fido.id)
    petapp2 = PetApplication.create!(application_id: @app.id, pet_id: @santa.id)
  end

  # 12. Approving a Pet for Adoption

  # As a visitor
  # When I visit an admin application show page ('/admin/applications/:id')
  # For every pet that the application is for, I see a button to approve the application for that specific pet
  # When I click that button
  # Then I'm taken back to the admin application show page
  # And next to the pet that I approved, I do not see a button to approve this pet
  # And instead I see an indicator next to the pet that they have been approved
  it 'should have a list of the pets on the application' do
    visit "/admin/applications/#{@app.id}"
    expect(page).to have_content("Application Number: #{@app.id}")
    expect(page).to have_content(@fido.name)
    expect(page).to have_content(@santa.name)
  end

  it 'can approve pets' do
    visit "/admin/applications/#{@app.id}"
    expect(page).to have_button("Approve #{@fido.name} for #{@app.name}")
    click_button("Approve #{@fido.name} for #{@app.name}")
    expect(current_path).to eq "/admin/applications/#{@app.id}"
    expect(page).to_not have_button("Approve #{@fido.name} for #{@app.name}")
    expect(page).to have_content("#{@fido.name} approved for #{@app.name}")
  end

  it 'can reject pets' do
    visit "/admin/applications/#{@app.id}"
    expect(page).to have_button("Reject #{@fido.name} for #{@app.name}")
    click_button("Reject #{@fido.name} for #{@app.name}")
    expect(current_path).to eq "/admin/applications/#{@app.id}"
    expect(page).to_not have_button("Reject #{@fido.name} for #{@app.name}")
    expect(page).to have_content("#{@fido.name} rejected for #{@app.name}")
  end
end
