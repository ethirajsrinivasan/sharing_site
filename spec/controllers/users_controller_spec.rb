require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let (:user) { User.create(email: "user@example.org", password: "very-secret", username: "user") }
  let(:location) { Location.create(latitude: 10,longitude: 5,public_site: true,user_id: user.id)}
  let(:location1) { Location.create(latitude: 10,longitude: 50,public_site: false,user_id: user.id)}
  let (:user1) { User.create(email: "user1@example.org", password: "very-secret1", username: "user1") }
  


  describe "GET show" do
    it "renders the show template" do
      sign_in user
      get :show
      expect(response).to render_template("show")
    end

    it "assigns @public locations" do
      sign_in user
      get :show
      expect(assigns(:public_locations)).to eq([location])
    end

    it "assigns @private locations" do
      sign_in user
      get :show
      expect(assigns(:private_locations)).to eq([location1])
    end

    it "assigns @shared locations" do
      sign_in user1
      get :show
      location1.shared_user_ids = [user1.id]
      expect(assigns(:shared_locations)).to eq([location1])
    end
  end
end
