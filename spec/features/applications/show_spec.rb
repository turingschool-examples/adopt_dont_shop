require 'rails_helper'

RSpec.describe 'application show page' do
  before(:each) do
    @application_1 = Application.create!(name: "Britney Spears", address: "400 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027)
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(name: "Pork Chop", age: 6, breed: "Poodle", adoptable: true, shelter_id: @shelter_1.id)
    @pet_2 = Pet.create!(name: "Tiny", age: 4, breed: "Great Dane", adoptable: true, shelter_id: @shelter_1.id)
    @pet_3 = Pet.create!(name: "Richard", age: 5, breed: "Maine Coone", adoptable: true, shelter_id: @shelter_1.id)
  end

  it 'diplays the applications name and attributes' do
    PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    PetApplication.create!(pet_id: @pet_2.id, application_id: @application_1.id)

    visit "/applications/#{@application_1.id}"

    within('#app-attributes') do
      expect(page).to have_content(@application_1.name)
      expect(page).to have_content(@application_1.address)
      expect(page).to have_content(@application_1.city)
      expect(page).to have_content(@application_1.state)
      expect(page).to have_content(@application_1.zipcode)
      expect(page).to have_content(@application_1.status)
      expect(page).to have_link(@pet_1.name)
    end
  end

  it 'has links to each pets show page' do
    PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    PetApplication.create!(pet_id: @pet_2.id, application_id: @application_1.id)

    visit "/applications/#{@application_1.id}"

    click_link "#{@pet_1.name}"

    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end

  it 'has a section to add pet to application if the application is not submitted' do
    visit "/applications/#{@application_1.id}"

    within('#adding-pets') do
      expect(page).to have_content("Add a Pet to this Application")

      fill_in :search, with: "Pork Chop"
      click_button('Search')

      expect(current_path).to eq("/applications/#{@application_1.id}")
    end

    within('#pet-results') do
      expect(page).to have_content('Pork Chop')
    end
  end

  it 'displays a link to adopt pet from search results' do
    visit "/applications/#{@application_1.id}"

    within('#adding-pets') do
      fill_in :search, with: "Pork Chop"
      click_button('Search')

      expect(current_path).to eq("/applications/#{@application_1.id}")
    end

    within('#pet-results') do
      click_button "Adopt this Pet"

      expect(current_path).to eq("/applications/#{@application_1.id}")
    end
save_and_open_page
    within('#app-attributes') do
      expect(page).to have_content("Pork Chop")
    end
  end

  it 'has a submit section after you add pets to the application' do
    visit "/applications/#{@application_1.id}"

    within('#adding-pets') do
      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to_not have_content("Submit")
      fill_in :search, with: "Pork Chop"
      click_button('Search')

      expect(current_path).to eq("/applications/#{@application_1.id}")
    end

    within('#pet-results') do
      click_button("Adopt this Pet")
      expect(current_path).to eq("/applications/#{@application_1.id}")
    end

    within('#application-submission') do
      expect(page).to have_content("Submit Your Application")

      fill_in('Description', with: 'Pork Chop seems nice')
      click_button('Submit Application')

      expect(current_path).to eq("/applications/#{@application_1.id}")
      expect(page).to_not have_content("Submit Application")
      # expect(page).to_not have_content()
    end
  end

  it 'displays pet names which partially match the search' do
    visit "/applications/#{@application_1.id}"
    within('#adding-pets') do
      expect(page).to have_content("Add a Pet to this Application")

      fill_in :search, with: "Por"
      click_button('Search')
      save_and_open_page
      expect(current_path).to eq("/applications/#{@application_1.id}")
    end

    within('#pet-results') do
      expect(page).to have_content("Pork Chop")
    end
  end

  # describe 'submitting an application' do
  #   context 'without pets on the application' do
  #     it 'does not allow submission' do
  #       visit "/applications/#{@application_1.id}"
  #       expect(page).to_not have_content('#application-submission')
  #     end
  #   end
  #
  #   context 'with pets on the application' do
  #     before(:each) do
  #       PetApplication.new(pet_id: @pet_1.id, application_id: @application_1.id).save
  #       visit "/applications/#{@application_1.id}"
  #     end
  #
  #     it 'has submission form with reason field' do
  #       within('#pet-results') do
  #         fill_in :search, with: "Pork Chop"
  #         click_button('Search')
  #         expect(current_path).to eq("/applications/#{@application_1.id}")
  #       end
  #
  #       within('#application-submission') do
  #         expect(page).to have_field("reason")
  #         expect(page).to have_button("Submit")
  #       end
  #     end
  #
  #       within('#pet-results') do
  #         click_button "Adopt this Pet"
  #
  #         expect(current_path).to eq("/applications/#{@application_1.id}")
  #       end
  #     it 'allows you to submit an application' do
  #
  #     end
  #   end
  #
  #
  # end
end
