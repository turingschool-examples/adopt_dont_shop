require 'rails_helper'

RSpec.describe 'index page' do
  it "shows the shelters in alphabetical order" do
    shelter = Shelter.create!(foster_program: true, name: 'Pet Semetary', city: 'Chicago', rank: 8)
    shelter2 = Shelter.create!(foster_program: false, name: 'Boone County', city: 'STL', rank: 2)
    shelter3 = Shelter.create!(foster_program: true, name: 'Turing', city: 'Denver', rank: 5)

    visit "/admin/shelters"

    expect(shelter.name).to appear_before(shelter2.name)
    expect(shelter3.name).to appear_before(shelter.name)
    expect(shelter3.name).to appear_before(shelter2.name)
#     SQL Only Story
#
# For this story, you should write your queries in raw sql. You can use the ActiveRecord find_by_sql method to execute raw sql queries: https://guides.rubyonrails.org/active_record_querying.html#finding-by-sql
#
# As a visitor
# When I visit the admin shelter index ('/admin/shelters')
# Then I see all Shelters in the system listed in reverse alphabetical order by name
  end
end
