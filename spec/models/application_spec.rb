require 'rails_helper'

describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
  end

  before do
    @application1 = Application.create!(name: "Paul Leonard",
                                        address: "123 Smiley St.",
                                        city: "Atlanta",
                                        state: "Georgia",
                                        zip: "31768",
                                        description: "Single guy, 3 bedroom house on 7 acres.  Lots of love to give!",
                                        status: "Pending")
  end
end

#   describe 'model methods' do  #abandoned full_address method for now
#     describe 'instance methods' do
#       describe 'full_address' do
#         # it "adds attributes to make a full address" do
#         #   expect(@application1.full_address).to eq("123 Smiley St. A")
#         # end
#
#     end
#   end
# end
