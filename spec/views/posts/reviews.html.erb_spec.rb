require "spec_helper"

describe "posts/reviews.html.erb", :type => :view do
  xit "displays the title of two reviews" do
    assign(:reviews, [
      stub_model(Post, :title => "oh no", category: 'review'),
      stub_model(Post, :title => "hell yeah", category: 'review')]
    )

    render

    expect(rendered).to match /no/
    expect(rendered).to match /hell/
  end

  it "displays a default message when there are no reviews to show" do
    assign(:reviews, [])

    render

    expect(rendered).to match /soon/
  end
end