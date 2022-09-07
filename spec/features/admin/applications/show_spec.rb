require 'rails_helper'

RSpec.describe 'the admin application view page' do
  before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald')
    @pet_2 = @shelter_1.pets.create!(adoptable: true, age: 7, breed: 'yorkie', name: 'Mr. Pig')
    @pet_3 = @shelter_2.pets.create!(adoptable: true, age: 348, breed: 'Wookie', name: 'Bark Hamill')
    @pet_4 = @shelter_2.pets.create!(adoptable: true, age: 4, breed: 'long hair', name: 'Sweet Potato')
    @pet_5 = @shelter_3.pets.create!(adoptable: true, age: 6, breed: 'Huskey', name: 'Todd')
    @pet_6 = @shelter_3.pets.create!(adoptable: true, age: 2, breed: 'Calico', name: 'Potato Chip')

    @application_1 = Application.create!(name: "Shelby Waters", street_address: "274 West 11th St", city: "Myers Flatt", state: "NJ", zipcode: 12447, status: "Pending", description: "I'm Lonely")
    @application_2 = Application.create!(name: "Florence Bigsby", street_address: "202 E Washington Ave", city: "Madison", state: "WI", zipcode: 60637, status: "Pending", description: "I love cats")
    @application_3 = Application.create!(name: "Todd Matthews", street_address: "620 W 11th St", city: "Hastings", state: "MN", zipcode: 55033, status: "Pending", description: "We have the same name")
    @application_4 = Application.create!(name: "Burton Guster", street_address: "1112 Beach Ave", city: "Santa Barbra", state: "CA", zipcode: 55033, status: "Pending", description: "I have lots of Mice")
    @application_5 = Application.create!(name: "Shawn Spencer", street_address: "125 Amber Way", city: "Eureka", state: "CA", zipcode: 97401, status: "Pending", description: "My roomate is annoying and allergic")

    @application_1.pets << @pet_1
    @application_1.pets << @pet_3
    @application_2.pets << @pet_2
    @application_3.pets << @pet_5
    @application_4.pets << @pet_3
    @application_5.pets << @pet_3

  end

  describe 'when I visit the admin application show page' do
    it 'displays all pets applying for' do
      visit "admin/applications/#{@application_1.id}"

      expect(page).to have_content('Lucille Bald')
      expect(page).to have_content('Bark Hamill')

      expect(page).to_not have_content('Mr. Pig')
    end

    it 'has a button to approve an appliaction for a specific pet' do
      visit "admin/applications/#{@application_2.id}"

      expect(page).to have_content('Mr. Pig')

      click_on 'Approve'

      expect(current_path).to eq("/admin/applications/#{@application_2.id}")
      expect(page).to have_content('Mr. Pig')
    end

    it 'once a pet is approved, there is an indicator that the pet has been approved and the buttons are gone' do
      visit "admin/applications/#{@application_2.id}"

      expect(page).to have_content('Mr. Pig')

      within(".pet_#{@pet_2.id}") do
        click_on 'Approve'
      end

      within(".pet_#{@pet_2.id}") do

        expect(page).to_not have_content('Reject')
        expect(page).to have_content('Approved')
      end
    end

    it 'has a button to reject the application for a specific pet' do
      visit "admin/applications/#{@application_3.id}"

      expect(page).to have_content('Todd')

      within(".pet_#{@pet_5.id}") do
        click_on 'Reject'
      end

      expect(current_path).to eq("/admin/applications/#{@application_3.id}")
      expect(page).to have_content('Todd')
    end

    it 'once a pet is rejected, there is an indicator that the pet has been rejected and the buttons are gone' do
      visit "admin/applications/#{@application_3.id}"

      expect(page).to have_content('Todd')

      within(".pet_#{@pet_5.id}") do
        click_on 'Reject'
      end

      within(".pet_#{@pet_5.id}") do

        expect(page).to_not have_content('Approved')
        expect(page).to have_content('Rejected')
      end
    end

    describe 'a program that allows one to approve two applications for the same pet' do

      it 'can approve Bark Hamill after approving him on another application' do
        visit "admin/applications/#{@application_4.id}"

        within(".pet_#{@pet_3.id}") do
          click_on 'Approve'
        end

        expect(page).to have_content('Approved')
        expect(page).to_not have_content('Rejected')

        visit "admin/applications/#{@application_5.id}"

        expect(page).to have_button('Approve')
        expect(page).to have_button('Reject')

        within(".pet_#{@pet_3.id}") do
          click_on 'Approve'
        end

        expect(page).to have_content('Approved')
        expect(page).to_not have_content('Rejected')
      end

    end

    describe 'a program that allows one to deny two applications for the same pet' do

      it 'can approve Bark Hamill after approving him on another application' do
        visit "admin/applications/#{@application_4.id}"

        within(".pet_#{@pet_3.id}") do
          click_on 'Reject'
        end

        expect(page).to have_content('Rejected')
        expect(page).to_not have_content('Approved')

        visit "admin/applications/#{@application_5.id}"

        expect(page).to have_button('Approve')
        expect(page).to have_button('Reject')

        within(".pet_#{@pet_3.id}") do
          click_on 'Reject'
        end

        expect(page).to have_content('Rejected')
        expect(page).to_not have_content('Approved')
      end

    end

    describe 'a program that allows one to deny an application and aprove another application for the same pet' do

      it 'can approve Bark Hamill after approving him on another application' do
        visit "admin/applications/#{@application_4.id}"

        within(".pet_#{@pet_3.id}") do
          click_on 'Reject'
        end

        expect(page).to have_content('Rejected')
        expect(page).to_not have_content('Approved')

        visit "admin/applications/#{@application_5.id}"

        expect(page).to have_button('Approve')
        expect(page).to have_button('Reject')

        within(".pet_#{@pet_3.id}") do
          click_on 'Approve'
        end

        expect(page).to have_content('Approved')
        expect(page).to_not have_content('Rejected')
        expect(page).to_not have_content('Accept')
        expect(page).to_not have_content('Reject')
      end

    end
  end
end
