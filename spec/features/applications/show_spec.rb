require 'rails_helper'

RSpec.describe "Applications Show" do
  before :each do
    application_1 = Application.create!(name: "Carol Crikey", street_address: "2022 S Fake Street", city: "Birmingham", state: "AL", zip_code: "54738", status: "In Progress")
  end
end
