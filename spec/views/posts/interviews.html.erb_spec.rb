require "spec_helper"

describe "posts/interviews.html.erb", :type => :view do
  xit "displays the title of two interviews" do
    assign(:interviews, [
      stub_model(Post, :title => "oh no", category: 'interview'),
      stub_model(Post, :title => "hell yeah", category: 'interview')]
    )

    render

    expect(rendered).to match /no/
    expect(rendered).to match /hell/
  end

  it "displays a default message when there are no reviews to show" do
    assign(:interviews, [])

    render

    expect(rendered).to match /soon/
  end
end