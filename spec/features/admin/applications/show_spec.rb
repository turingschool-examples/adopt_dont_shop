require 'rails_helper'

describe 'admin applications show' do
  before(:each) do
    @app = create(:application, description: 'I like dogs.', status: 'Pending')
    @shelter = create(:shelter)
    @pet_1 = create(:pet, shelter_id: @shelter.id)
    @pet_2 = create(:pet, shelter_id: @shelter.id)
    @petapp_1 = PetApplication.create!(application_id: @app.id, pet_id: @pet_1.id)
    @petapp_2 = PetApplication.create!(application_id: @app.id, pet_id: @pet_2.id)
  end

  # 12. Approving a Pet for Adoption
  it 'should have a list of the pets on the application' do
    visit "/admin/applications/#{@app.id}"
    expect(page).to have_content("Application Number: #{@app.id}")
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
  end

  it 'can approve pets' do
    visit "/admin/applications/#{@app.id}"
    expect(page).to have_button("Approve #{@pet_1.name} for #{@app.name}")
    click_button("Approve #{@pet_1.name} for #{@app.name}")
    expect(current_path).to eq "/admin/applications/#{@app.id}"
    expect(page).to_not have_button("Approve #{@pet_1.name} for #{@app.name}")
    expect(page).to have_content("#{@pet_1.name} approved for #{@app.name}")
  end

  it 'can reject pets' do
    visit "/admin/applications/#{@app.id}"
    expect(page).to have_button("Reject #{@pet_1.name} for #{@app.name}")
    click_button("Reject #{@pet_1.name} for #{@app.name}")
    expect(current_path).to eq "/admin/applications/#{@app.id}"
    expect(page).to_not have_button("Reject #{@pet_1.name} for #{@app.name}")
    expect(page).to have_content("#{@pet_1.name} rejected for #{@app.name}")
  end

  it 'pets on one application do not affect other applications (Approve)' do
    visit "/admin/applications/#{@app.id}"
    expect(page).to have_button("Approve #{@pet_1.name} for #{@app.name}")
    expect(page).to have_button("Reject #{@pet_1.name} for #{@app.name}")
    expect(page).to have_button("Approve #{@pet_2.name} for #{@app.name}")
    expect(page).to have_button("Reject #{@pet_2.name} for #{@app.name}")

    click_button("Approve #{@pet_1.name} for #{@app.name}")

    expect(page).to have_button("Approve #{@pet_2.name} for #{@app.name}")
    expect(page).to have_button("Reject #{@pet_2.name} for #{@app.name}")
  end

  it 'pets on one application do not affect other applications (Reject)' do
    visit "/admin/applications/#{@app.id}"
    click_button("Reject #{@pet_1.name} for #{@app.name}")

    expect(page).to have_button("Approve #{@pet_2.name} for #{@app.name}")
    expect(page).to have_button("Reject #{@pet_2.name} for #{@app.name}")
  end

  it 'Does not affect other applications when another button is clicked on an application' do
    # 14. Approved/Rejected Pets on one Application do not affect other Applications
    app2 = Application.create!(name: 'Homer Simpson',
                               address: '742 Evergreen Terrace',
                               city: 'Springfield',
                               state: 'IL',
                               zipcode: 12_345,
                               description: 'I like dogs more than John.',
                               status: 'Pending')
    petapp2 = PetApplication.create!(application_id: app2.id, pet_id: @pet_1.id)
    visit "/admin/applications/#{@app.id}"
    click_button("Approve #{@pet_1.name} for #{@app.name}")
    visit "/admin/applications/#{app2.id}"
    expect(page).to have_button("Approve #{@pet_1.name} for #{app2.name}")
    expect(page).to have_button("Reject #{@pet_1.name} for #{app2.name}")
  end

  it 'Changes application\'s status' do
    # 15. All Pets Accepted on an Application
    visit "/admin/applications/#{@app.id}"
    expect(page).to have_content('Application Status: Pending')
    click_button("Approve #{@pet_1.name} for #{@app.name}")
    click_button("Approve #{@pet_2.name} for #{@app.name}")
    expect(current_path).to eq "/admin/applications/#{@app.id}"
    expect(page).to have_content('Application Status: Approved')
  end

  it 'one or more pets rejected on an application' do
    # 16. One or More Pets Rejected on an Application
    visit "/admin/applications/#{@app.id}"
    expect(page).to have_content('Application Status: Pending')
    click_button("Reject #{@pet_1.name} for #{@app.name}")
    click_button("Approve #{@pet_2.name} for #{@app.name}")
    expect(current_path).to eq "/admin/applications/#{@app.id}"
    expect(page).to have_content('Application Status: Rejected')
  end

  it 'changes the pets adoptable status to false when the application is approved' do
    # 17. Application Approval makes Pets not adoptable
    visit "/admin/applications/#{@app.id}"
    expect(@pet_1.adoptable).to be(true)
    click_button("Approve #{@pet_1.name} for #{@app.name}")
    click_button("Approve #{@pet_2.name} for #{@app.name}")
    visit "/pets/#{@pet_1.id}"
    expect(page).to have_content('false')
  end

  it 'does not have the option to approve a pet if it is not adoptable' do
    app_2 = Application.create!(name: 'John Smith',
                                address: '123 Fake Street',
                                city: 'Springfield',
                                state: 'IL',
                                zipcode: 12_345,
                                description: 'I like dogs.',
                                status: 'Pending')
    PetApplication.create!(application_id: app_2.id, pet_id: @pet_1.id)
    PetApplication.create!(application_id: app_2.id, pet_id: @pet_2.id)
    visit "/admin/applications/#{@app.id}"
    expect(@pet_1.adoptable).to be(true)
    click_button("Approve #{@pet_1.name} for #{@app.name}")
    click_button("Approve #{@pet_2.name} for #{@app.name}")
    visit "/admin/applications/#{app_2.id}"
    expect(page).to have_content('This pet has already been approved for adoption')
    expect(page).to_not have_button("Approve #{@pet_1.name} for #{app_2.name}")
    expect(page).to_not have_button("Approve #{@pet_2.name} for #{app_2.name}")
  end
end
