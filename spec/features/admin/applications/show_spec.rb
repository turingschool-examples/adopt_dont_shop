require 'rails_helper'

RSpec.describe 'the admin shelter show page ' do
  it 'shows all the pets on the applicatrion' do
    shelter = Shelter.create!(foster_program: false, name: 'Humane Society', city: 'Phoenix', rank: 20)
    application = Application.create!(name: 'Cory', city: 'Tempe', state: 'AZ', street_address: '3030 Westroad', zip_code: '85282', description: 'I love dogs and I have a lot of free time to take care of one.', status: 'Pending')
    spot = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Spot', shelter_id: shelter[:id])
    bognart = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Bognart', shelter_id: shelter[:id])
    poopy = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Poopy', shelter_id: shelter[:id])
    ApplicationPet.create!(pet_id: spot.id, application_id: application.id)
    ApplicationPet.create!(pet_id: poopy.id, application_id: application.id)
    ApplicationPet.create!(pet_id: bognart.id, application_id: application.id)

    visit "/admin/applications/#{application.id}"

    expect(page).to have_content(spot.name)
    expect(page).to have_content(bognart.name)
    expect(page).to have_content(poopy.name)
  end

  it 'can approve an application' do
    shelter = Shelter.create!(foster_program: false, name: 'Humane Society', city: 'Phoenix', rank: 20)
    application = Application.create!(name: 'Cory', city: 'Tempe', state: 'AZ', street_address: '3030 Westroad', zip_code: '85282', description: 'I love dogs and I have a lot of free time to take care of one.', status: 'Pending')
    spot = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Spot', shelter_id: shelter[:id])
    bognart = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Bognart', shelter_id: shelter[:id])
    poopy = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Poopy', shelter_id: shelter[:id])
    ApplicationPet.create!(pet_id: spot.id, application_id: application.id)
    ApplicationPet.create!(pet_id: poopy.id, application_id: application.id)
    ApplicationPet.create!(pet_id: bognart.id, application_id: application.id)

    visit "/admin/applications/#{application.id}"
    expect(page).to have_button("Approve Application for Spot")
    expect(page).to have_button("Approve Application for Poopy")
    expect(page).to have_button("Approve Application for Bognart")


    click_button("Approve Application for Spot")

    expect(page).to_not have_button("Approve Application for Spot")
    expect(page).to have_button("Approve Application for Poopy")
    expect(page).to have_button("Approve Application for Bognart")
    expect(page).to have_content("Spot Approved")


  end

  it 'can reject an application' do
    shelter = Shelter.create!(foster_program: false, name: 'Humane Society', city: 'Phoenix', rank: 20)
    application = Application.create!(name: 'Cory', city: 'Tempe', state: 'AZ', street_address: '3030 Westroad', zip_code: '85282', description: 'I love dogs and I have a lot of free time to take care of one.', status: 'Pending')
    spot = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Spot', shelter_id: shelter[:id])
    bognart = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Bognart', shelter_id: shelter[:id])
    poopy = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Poopy', shelter_id: shelter[:id])
    ApplicationPet.create!(pet_id: spot.id, application_id: application.id)
    ApplicationPet.create!(pet_id: poopy.id, application_id: application.id)
    ApplicationPet.create!(pet_id: bognart.id, application_id: application.id)

    visit "/admin/applications/#{application.id}"
    expect(page).to have_button("Reject Application for Spot")
    expect(page).to have_button("Reject Application for Poopy")
    expect(page).to have_button("Reject Application for Bognart")

    save_and_open_page
    click_button("Reject Application for Spot")
    save_and_open_page
    click_button("Reject Application for Bognart")

    expect(page).to_not have_button("Reject Application for Spot")
    expect(page).to_not have_button("Reject Application for Bognart")
    expect(page).to have_button("Reject Application for Poopy")
    expect(page).to have_content("Spot Rejected")
    expect(page).to have_content("Bognart Rejected")
  end

  it 'one application does not affect another' do
    shelter = Shelter.create!(foster_program: false, name: 'Humane Society', city: 'Phoenix', rank: 20)
    application1 = Application.create!(name: 'Cory', city: 'Tempe', state: 'AZ', street_address: '3030 Westroad', zip_code: '85282', description: 'I love dogs and I have a lot of free time to take care of one.', status: 'Pending')
    application2 = Application.create!(name: 'Drew', city: 'Los Angeles', state: 'CA', street_address: '6969 Bonky', zip_code: '69420', description: 'I have a fever and the only cure is more dog bell.', status: 'Pending')
    spot = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Spot', shelter_id: shelter[:id])
    bognart = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Bognart', shelter_id: shelter[:id])
    poopy = Pet.create!(adoptable: true, age: 2, breed: 'Mix', name: 'Poopy', shelter_id: shelter[:id])
    ApplicationPet.create!(pet_id: spot.id, application_id: application1.id)
    ApplicationPet.create!(pet_id: poopy.id, application_id: application1.id)
    ApplicationPet.create!(pet_id: bognart.id, application_id: application2.id)
    ApplicationPet.create!(pet_id: spot.id, application_id: application2.id)

    visit "/admin/applications/#{application1.id}"

    expect(page).to have_button("Reject Application for Spot")
    expect(page).to have_button("Reject Application for Poopy")
    expect(page).to have_button("Approve Application for Spot")
    expect(page).to have_button("Approve Application for Poopy")

    click_button("Reject Application for Spot")

    visit "/admin/applications/#{application2.id}"

    expect(page).to have_button("Reject Application for Spot")
    expect(page).to have_button("Reject Application for Bognart")
    expect(page).to have_button("Approve Application for Spot")
    expect(page).to have_button("Approve Application for Bognart")

  end

end
