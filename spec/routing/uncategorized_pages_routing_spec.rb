require "rails_helper"

RSpec.describe "routes for uncategorized pages", :type => :routing do
  it "routes / to the home page" do
    expect(get("/")).to route_to("uncategorized_pages#home_two")
  end

  it "routes /about to the about page" do
    expect(get("/about")).to route_to("uncategorized_pages#about")
  end

  it "routes /contact to the home page" do
    expect(get("/contact")).to route_to("uncategorized_pages#contact")
  end
end