require "spec_helper"

describe "posts/guides.html.erb", :type => :view do
  

  it "displays a default message when there are no reviews to show" do
    assign(:guides, [])

    render

    expect(rendered).to match /soon/
  end
end