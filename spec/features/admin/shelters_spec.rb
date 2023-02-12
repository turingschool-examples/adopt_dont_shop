require 'rails_helper'

describe 'admin shelter index' do
  # SQL Only Story
  # For this story, you should write your queries in raw sql. You can use the ActiveRecord find_by_sql method to execute raw sql queries: https://guides.rubyonrails.org/active_record_querying.html#finding-by-sql
  # 10. Admin Shelters Index
  # As a visitor
  # When I visit the admin shelter index ('/admin/shelters')
  # Then I see all Shelters in the system listed in reverse alphabetical order by name
  it 'lists all the shelters in reverse alphabetical order' do
    shelter1 = Shelter.create!(
                                foster_program: true,
                                name: 'Alpha house',
                                city: 'Springfield',
                                rank: 1
                              )
    shelter2 = Shelter.create!(
                                foster_program: true,
                                name: 'Sigma house',
                                city: 'Springfield',
                                rank: 3
                              )
    shelter3 = Shelter.create!(
                                foster_program: true,
                                name: 'Beta house',
                                city: 'Springfield',
                                rank: 2
                              )
    shelter4 = Shelter.create!(
                                foster_program: true,
                                name: 'Omega house',
                                city: 'Springfield',
                                rank: 7
                              )
    visit '/admin/shelters'
    expect(shelter2.name).to appear_before(shelter4.name)
    expect(shelter4.name).to appear_before(shelter3.name)
    expect(shelter3.name).to appear_before(shelter1.name)
  end
end