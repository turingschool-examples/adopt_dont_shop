require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows the application and attributes" do
    application = Application.create!(name: 'Andrew', street: "123 Street", city: "Kenosha",
    state: "WI", zip: 53144, description: "This is a description of why I'm a good fit.",
    application_status: "In Progress")

    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.application_status)
end

end
