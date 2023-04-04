require 'rails_helper'

RSpec.describe 'admin shelters' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_1 = @shelter_1.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow')
    @application_1 = @pet_1.applications.create(
      name: "Billy Mays",
      street_address:  "123 Main St",
      city: "Aurora",
      state: "CO",
      zip: "80012",
      description: "I like pets",
      status: "Pending"
  )
  @application_2 = @pet_1.applications.create(
    name: "Gwen Stefani",
    street_address:  "125 Main St",
    city: "Aurora",
    state: "CO",
    zip: "80012",
    description: "I like pets even more",
    status: "In Progress"
  )
  end

  it 'shows shelters with pending applications' do
    visit '/admin/shelters' 
    expect(page).to have_content("#{@shelter_1.name}")
  end

  #User Story 10
  describe "When i visit /admin/shelters" do
    it "displays all shelters in reverse alphabetical order" do
      visit '/admin/shelters' 
      expect(@shelter_2.name).to appear_before(@shelter_3.name)
      expect(@shelter_3.name).to appear_before(@shelter_1.name)
    end
  end

  #User Story 19
  describe "Admin Shelters Show Page" do
    it "has the shelters name and full address" do
      visit "admin/shelters/#{@shelter_1.id}"
      save_and_open_page 
      expect(page).to have_content("#{@shelter_1.name}")
      expect(page).to have_content("#{@shelter_1.city}")
    end
  end
end

# Customer.find_by_sql("SELECT * FROM customers INNER JOIN
#    orders ON customers.id = orders.customer_id 
#    ORDER BY customers.created_at desc")

# [ ] done

# SQL Only Story

# For this story, you should write your queries in raw sql. You can use the ActiveRecord find_by_sql method to execute raw sql queries: https://guides.rubyonrails.org/active_record_querying.html#finding-by-sql

# 19. Admin Shelters Show Page

# As a visitor
# When I visit an admin shelter show page
# Then I see that shelter's name and full address

# NOTE: Your query should only return the necessary data to complete the story

