require 'rails_helper'

RSpec.describe "Exercises", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/exercises/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/exercises/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/exercises/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/exercises/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/exercises/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
