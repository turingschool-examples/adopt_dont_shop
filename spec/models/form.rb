require 'rails_helper'

RSpec.describe Form, type: :model do
  describe 'relationships' do
    it { should have_many(:pet_forms) }
    it { should have_many(:pets).through(:pet_forms) }
  end

  describe 'status' do
    @form.status = 0
    (@form.status).to eq("In Progress")
    @form.status = 1
    (@form.status).to eq("Pending")
    @form.status = 2
    (@form.status).to eq("Accepted")
    @form.status = 3
    (@form.status).to eq("Rejected")
  end
end