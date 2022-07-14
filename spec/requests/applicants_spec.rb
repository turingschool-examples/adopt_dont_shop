require 'rails_helper'

RSpec.describe "Applicants", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/applicants/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/applicants/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/applicants/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/applicants/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /_form" do
    it "returns http success" do
      get "/applicants/_form"
      expect(response).to have_http_status(:success)
    end
  end

end
