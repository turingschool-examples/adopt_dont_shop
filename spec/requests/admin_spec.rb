require 'rails_helper'

RSpec.describe "Admins", type: :request do
  describe "GET /shelter" do
    it "returns http success" do
      get "/admin/shelter"
      expect(response).to have_http_status(:success)
    end
  end

end
