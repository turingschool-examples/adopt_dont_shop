require "rails_helper"

RSpec.describe 'admin applications show spec' do
  before(:each) do
    @shelter1 = Shelter.create(name: 'Lovely paws', city: 'Aurora, CO', foster_program: false, rank: 4)
    @shelter2 = Shelter.create(name: 'Pit Rescue', city: 'Aurora, CO', foster_program: true, rank: 1)
    @shelter3 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    @pet1 = @shelter1.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter1.id)
    @pet2 = @shelter2.pets.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter2.id)
    @pet3 = @shelter3.pets.create(adoptable: true, age: 3, breed: 'maincoon', name: 'george', shelter_id: @shelter1.id)

    @olivia = Application.create(name: 'Olivia Charles' ,address: '2390 toad holler rd ', city: 'montrose', state: 'PA', zip_code: 12345, description: 'Love cats', status: 'Pending')

    PetApplication.create(pet_id: @pet1.id, application_id: @olivia.id, status: 'Pending')
    PetApplication.create(pet_id: @pet2.id, application_id: @olivia.id, status: 'Pending')
  end


  it 'for every pet there is a button to approve application for a specific pet.' do
    visit "/admin/applications/#{@olivia.id}"

    expect(page).to have_button("Approve #{@pet1.name} for Adoption")

    click_button "Approve #{@pet1.name} for Adoption"

    expect(current_path).to eq("/admin/applications/#{@olivia.id}")
    expect(page).to have_content("Application has been approved. CONGRATS")
    expect(page).to_not have_button("Approve #{@pet1.name}for Adoption")
  end

  it 'for every pet there is a button to reject application for a specific pet.' do
    visit "/admin/applications/#{@olivia.id}"

    expect(page).to have_button("Reject Application for #{@pet1.name}")

    click_button "Reject Application for #{@pet1.name}"

    expect(current_path).to eq("/admin/applications/#{@olivia.id}")
    expect(page).to have_content("This application has been rejected")
    expect(page).to_not have_button("Reject Application for #{@pet1.name}")
  end
end
