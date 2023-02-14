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

  it 'pets on one application do not affect other applications (Approve)' do
    visit "/admin/applications/#{@app.id}"
    expect(page).to have_button("Approve #{@fido.name} for #{@app.name}")
    expect(page).to have_button("Reject #{@fido.name} for #{@app.name}")
    expect(page).to have_button("Approve #{@santa.name} for #{@app.name}")
    expect(page).to have_button("Reject #{@santa.name} for #{@app.name}")

    click_button("Approve #{@fido.name} for #{@app.name}")

    expect(page).to have_button("Approve #{@santa.name} for #{@app.name}")
    expect(page).to have_button("Reject #{@santa.name} for #{@app.name}")
  end

  it 'pets on one application do not affect other applications (Reject)' do
    visit "/admin/applications/#{@app.id}"
    click_button("Reject #{@fido.name} for #{@app.name}")

    expect(page).to have_button("Approve #{@santa.name} for #{@app.name}")
    expect(page).to have_button("Reject #{@santa.name} for #{@app.name}")
  end

  it 'Does not affect other applications when another button is clicked on an application' do
    # 14. Approved/Rejected Pets on one Application do not affect other Applications

    #   As a visitor
    #   When there are two applications in the system for the same pet
    #   When I visit the admin application show page for one of the applications
    #   And I approve or reject the pet for that application
    #   When I visit the other application's admin show page
    #   Then I do not see that the pet has been accepted or rejected for that application
    #   And instead I see buttons to approve or reject the pet for this specific application
    app2 = Application.create!(name: 'Homer Simpson',
      address: '742 Evergreen Terrace',
      city: 'Springfield',
      state: 'IL',
      zipcode: 12345,
      description: 'I like dogs more than John.',
      status: 'Pending')
    petapp2 = PetApplication.create!(application_id: app2.id, pet_id: @fido.id)
    visit "/admin/applications/#{@app.id}"
    click_button("Approve #{@fido.name} for #{@app.name}")
    visit "/admin/applications/#{app2.id}"
    expect(page).to have_button("Approve #{@fido.name} for #{app2.name}")
    expect(page).to have_button("Reject #{@fido.name} for #{app2.name}")
  end
end
