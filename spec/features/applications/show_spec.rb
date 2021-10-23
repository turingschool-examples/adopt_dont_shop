require 'rails_helper'

RSpec.describe 'the application show' do
  it 'shows the application and all its attributes' do
    application = Application.create!(
                                      name: "Nate Brown",
                            street_address: "2000 35th Avenue",
                                      city: "Denver",
                                     state: "CO",
                                       zip: "90210",
                               description: "I have a big backyard",
                                    status: "In Progress"
                                      )

    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.full_address)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
  end
end
