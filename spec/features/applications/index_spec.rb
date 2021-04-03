require 'rails_helper'

RSpec.describe "the Application index page" do
  before :each do
    @foothills_shelter = Shelter.create!(name: 'Foothills Animal Shelter', city: 'Golden, CO', foster_program: true, rank: 4)
    @ramone = @foothills_shelter.pets.create!(name: 'Ramone', breed: 'hound', age: 2, adoptable: true)
    @lawson = @foothills_shelter.pets.create!(name: 'Lawson', breed: 'Australian shepherd', age: 6, adoptable: true)
    @petunia = @foothills_shelter.pets.create!(name: 'Petunia', breed: 'chihuahua', age: 1, adoptable: true)

    @com_truise = Application.create!(applicant_name: 'Com Truise',
      street: "123 Louisiana Ave.",
      city: "Denver",
      state: "CO",
      zip_code: "80001",
      statement: "I live near a park",
      status: "in progress"
    )
    @jeff_rosenstock = Application.create!(applicant_name: 'Jeff Rosenstock',
      street: "456 Mississippi Ave.",
      city: "Denver",
      state: "CO",
      zip_code: "80012",
      statement: "I have a fenced in yard",
      status: "pending"
    )
    @hayley_williams = Application.create!(applicant_name: 'Hayley Williams',
      street: "789 Rose St.",
      city: "Golden",
      state: "CO",
      zip_code: "80123",
      statement: "I sing to my pets",
      status: "pending"
    )

    @com_truise.pets << @ramone
    @com_truise.pets << @lawson
    @jeff_rosenstock.pets << @lawson
    @hayley_williams.pets << @petunia

    visit "/applications"
  end

  it "lists all applications" do
    expect(page).to have_content(@com_truise.applicant_name)
    expect(page).to have_content(@jeff_rosenstock.applicant_name)
    expect(page).to have_content(@hayley_williams.applicant_name)
  end

  # it "lists the applications by..." do
  #   # user story?
  # end

  # it "user story thing" do
    # within("#application-#{@com_truise.id}") do
    #   expect(page).to have_content(rock.name)
    #   expect(page).to have_content(place.title)
    #   expect(page).to have_content(breadbox.title)
    #   expect(page).to have_content(r_and_c.title)
    # end
  # end
end
