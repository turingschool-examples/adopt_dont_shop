require 'rails_helper'

RSpec.describe "Filling out forms" do
  
 it 'fills out form' do
  visit "/applications/new"

  fill_in "name", with: "Jimbo"
  fill_in "street_address", with: "269 North"
  fill_in "city", with: "Provo"
  fill_in "state", with: "UT"
  fill_in "zip", with: "84606"
  fill_in "description", with: "pass the test please"
  
  click_button "Create Application"
 end
end