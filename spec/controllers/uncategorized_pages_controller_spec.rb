require "rails_helper"

RSpec.describe UncategorizedPagesController, :type => :controller do
  describe "GET home" do
    it "has a 200 status code" do
      get :home_two
      expect(response.status).to eq(200)
    end
  end

  describe "GET about" do
    it "has a 200 status code" do
      get :about
      expect(response.status).to eq(200)
    end
  end

  describe "GET contact" do
    it "has a 200 status code" do
      get :contact
      expect(response.status).to eq(200)
    end
  end
end