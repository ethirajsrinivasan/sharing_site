require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new }

  let (:user) { User.create(email: "user@example.org", password: "very-secret", username: "user") }
  let(:location) { Location.create(latitude: 10,longitude: 5,public_site: true,user_id: user.id)}
  let(:location1) { Location.create(latitude: 10,longitude: 51,public_site: false,user_id: user.id)}
  let (:user1) { User.create(email: "user1@example.org", password: "very-secret1", username: "user1") }

  it "is valid with valid attributes" do
    subject.email = "ethirajsrinivasan@gmail.com"
    subject.password = "password"
    subject.username  = "ethiraj"
    expect(subject).to be_valid
  end

  it "is not valid without a email" do
    expect(subject).to_not be_valid
  end

  it "is not valid without a password" do
  	subject.email = "ethirajsrinivasan@gmail.com"
    expect(subject).to_not be_valid
  end

  it "is not valid without a username" do
  	subject.email = "ethirajsrinivasan@gmail.com"
    subject.password = "password"
    expect(subject).to_not be_valid
  end

  describe "Association" do
  	it "should have many locations" do
  		assc = User.reflect_on_association(:locations)
    	expect(assc.macro).to eq :has_many
      expect(user.locations).to eq [location, location1]
  	end

  	it "should have many location users" do
  		assc = User.reflect_on_association(:location_users)
    	expect(assc.macro).to eq :has_many
      location1.shared_user_ids = [user1.id]
      expect(user1.location_users).to eq [LocationUser.last]
  	end

  	it "should have many shared_location" do
  		assc = User.reflect_on_association(:shared_locations)
    	expect(assc.macro).to eq :has_many
      location1.shared_user_ids = [user1.id]
      expect(user1.shared_locations).to eq [location1]
  	end
  end
end
