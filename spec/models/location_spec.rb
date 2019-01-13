require 'rails_helper'

RSpec.describe Location, type: :model do
  subject { Location.new }

  let(:user) { User.create(email:"email@email.com",password:"password",username: "username")}
  let(:location1) { Location.create(latitude: 10,longitude: 5,public_site: true,user_id: user.id)}
  let(:location2) { Location.create(latitude: 20,longitude: 50,public_site: false,user_id: user.id)}

  it "is valid with valid attributes" do
    subject.latitude = 10
    subject.longitude = 23
    subject.user_id  = user.id
    subject.public_site = true
    expect(subject).to be_valid
  end

  it "is not valid without a latitude" do
    expect(subject).to_not be_valid
  end

  it "is not valid without a longitude" do
  	subject.latitude = 10
    expect(subject).to_not be_valid
  end

  it "is not valid without a user" do
  	subject.latitude = 10
    subject.longitude = 23
    expect(subject).to_not be_valid
  end
  
  it "is not valid without public field" do
  	subject.latitude = 10
    subject.longitude = 23
    subject.user_id  = user.id
    expect(subject).to_not be_valid
  end

  it "should have latitude above -90" do
  	subject.latitude = -200
  	subject.longitude = 23
    subject.user_id  = user.id
    subject.public_site = true
    expect(subject).to_not be_valid
  end

  it "should have latitude below 90" do
  	subject.latitude = 100
  	subject.longitude = 23
    subject.user_id  = user.id
    subject.public_site = true
    expect(subject).to_not be_valid
  end

  it "should have longitude above -180" do
  	subject.latitude = 45
  	subject.longitude = -190
    subject.user_id  = user.id
    subject.public_site = true
    expect(subject).to_not be_valid
  end

  it "should have longitude below 180" do
  	subject.latitude = 45
  	subject.longitude = 200
    subject.user_id  = user.id
    subject.public_site = true
    expect(subject).to_not be_valid
  end

  describe "Association" do
  	it "should belong to user" do
  		assc = Location.reflect_on_association(:user)
    	expect(assc.macro).to eq :belongs_to
  	end

  	it "should have many location users" do
		assc = Location.reflect_on_association(:location_users)
		expect(assc.macro).to eq :has_many
  	end

  	it "should have many shared_users" do
  		assc = Location.reflect_on_association(:shared_users)
    	expect(assc.macro).to eq :has_many
  	end
  end

  describe "scope" do
    it "should have correct public locations" do
      expect(Location.public_locations).to eq [location1]
      expect(Location.public_locations).not_to eq [location2]
    end
    
    it "should have correct private locations" do
      expect(Location.private_locations).to eq [location2]
      expect(Location.private_locations).not_to eq [location1]
    end
  end
end
