require "spec_helper"

describe "posts/show.html.erb", :type => :view do
  xit "displays the title of the post" do
    assign(:post,
      stub_model(Post, :title => "hell yeah", :category => "guide")
    )

    render

    expect(rendered).to match /hell/
  end
end