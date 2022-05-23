RSpec.describe 'the application show' do
  it "shows the application and attributes" do
      application1 = Application.create!(name: 'Andrew', street: "123 Street", city: "Kenosha",
      state: "WI", zip: 53144, description: "This is a description of why I'm a good fit.",
      application_status: "In Progress")
      application2 = Application.create!(name: 'Eric', street: "345 Street", city: "Denver",
      state: "CO", zip: 22387, description: "This is a better description of why I'm a good fit.",
      application_status: "In Progress")

      visit "/applications"

      expect(page).to have_content(application1.name)
      expect(page).to have_content(application1.street)
      expect(page).to have_content(application1.city)
      expect(page).to have_content(application1.state)
      expect(page).to have_content(application1.zip)
      expect(page).to have_content(application1.description)
      expect(page).to have_content(application1.application_status)
      expect(page).to have_content(application2.name)
      expect(page).to have_content(application2.street)
      expect(page).to have_content(application2.city)
      expect(page).to have_content(application2.state)
      expect(page).to have_content(application2.zip)
      expect(page).to have_content(application2.description)
      expect(page).to have_content(application2.application_status)
  end
end
