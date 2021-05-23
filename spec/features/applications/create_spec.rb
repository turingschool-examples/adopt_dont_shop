require 'rails_helper'

RSpec.describe 'the application show' do

#   [ ] done
#
# Starting an Application
#
# As a visitor
# When I visit the pet index page
# Then I see a link to "Start an Application"
# When I click this link
# Then I am taken to the new application page where I see a form
# When I fill in this form with my:
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip Code
# And I click submit
# Then I am taken to the new application's show page
# And I see my Name, address information, and description of why I would make a good home
# And I see an indicator that this application is "In Progress"

  it "Fill out an form for a new application " do

    visit "/pets/"
    click_on "New Application"

    expect(current_path).to eq("/applications/new")

    fill_in( 'Name', with: "Daniel Casias")
    fill_in('address', with: '3456 East Spaulding Ave Parker, CO 80134')
    fill_in('Description', with: 'I would love a new pet!')
    click_button('Submit')

    expect(current_path).to eq('/applications')
    expect(page).to have_content('Daniel Casias')
  end

  # [ ] done

  # Starting an Application, Form not Completed
  #
  # As a visitor
  # When I visit the new application page
  # And I fail to fill in any of the form fields
  # And I click submit
  # Then I am taken back to the new applications page
  # And I see a message that I must fill in those fields.

  it "Will not let you submit a form that has empty fields" do

    visit "/pets/"
    click_on "New Application"

    expect(current_path).to eq("/applications/new")

    fill_in( 'Name', with: "Daniel Casias")
    click_button('Submit')

    expect(current_path).to eq("/applications/new")

    # fill_in( 'Name', with: "Daniel Casias")
    # fill_in('address', with: '3456 East Spaulding Ave Parker, CO 80134')
    # click_button('Submit')
    #
    # expect(current_path).to eq("/applications/new")
    #
    # fill_in( 'Name', with: "Daniel Casias")
    # fill_in('address', with: '3456 East Spaulding Ave Parker, CO 80134')
    # ill_in('Description', with: 'I would love a new pet!')
    # click_button('Submit')
    #
    # expect(current_path).to eq('/applications')
    # expect(page).to have_content('Daniel Casias')
  end

end
