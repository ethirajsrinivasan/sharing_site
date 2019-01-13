require 'rails_helper'

RSpec.describe LocationUser, type: :model do
  subject { LocationUser.new }

  let(:user) { User.create(email:"email@email.com",password:"password",username: "username")}
  let(:location) { Location.create(latitude: 10,longitude: 5,public_site: true,user_id: user.id)}

  it "is valid with valid attributes" do
    subject.location = location
    subject.user = user
    expect(subject).to be_valid
  end

  it "is not valid without a email" do
    expect(subject).to_not be_valid
  end

  it "is not valid without a password" do
    subject.location = location
    expect(subject).to_not be_valid
  end

  describe "Association" do
    it "should belong to user" do
      assc = LocationUser.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it "should belong to location" do
      assc = LocationUser.reflect_on_association(:location)
      expect(assc.macro).to eq :belongs_to
    end
  end

end