require "spec_helper"

describe "posts/new.html.erb", :type => :view do
  xit "displays a category selector" do
    assign(:post, stub_model(Post))
    render 

    expect(rendered).to match /category/
  end
end