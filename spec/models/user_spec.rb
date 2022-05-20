require 'rails_helper'

RSpec.describe User, :type => :model do
  subject { 
    described_class.new(email: "katrienv@gmail.com",
      password: "Katrien",
      first_name: "Katrien",
      last_name: "Vliegen")
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a first name" do 
    subject.first_name = ""
    expect(subject).not_to be_valid
  end

  it "is not valid without a last name" do
    subject.last_name = ""
    expect(subject).not_to be_valid

  end

  it "is not valid without an email address" do
    subject.email = ""
    expect(subject).not_to be_valid

  end
end