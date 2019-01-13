require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  let (:user) { User.create(email: "user@example.org", password: "very-secret", username: "user") }
  let(:location) { Location.create(latitude: 10,longitude: 5,public_site: true,user_id: user.id)}
  let(:location1) { Location.create(latitude: 10,longitude: 50,public_site: false,user_id: user.id)}
  let (:user1) { User.create(email: "user1@example.org", password: "very-secret1", username: "user1") }

  describe "GET show" do
    it "renders the show template" do
      sign_in user
      get :show, params: {id: location.id}
      expect(response).to render_template("show")
    end

    it "assigns @location" do
      sign_in user
      get :show, params: {id: location.id}
      expect(assigns(:location)).to eq(location)
    end
  end

  describe "GET new" do
    it "renders the new template" do
      sign_in user
      get :new
      expect(response).to render_template("new")
    end

    it "assigns @location" do
      sign_in user
      get :new
      expect(assigns(:location)).to be_a_new(Location)
    end
  end

  describe "post create" do
    it "should create location and location users" do
      sign_in user
      location_count = Location.count
      location_users_count = LocationUser.count
      post :create, params: {location: {latitude: 5,longitude: 6,shared_user_ids: ["",user1.id]}}
      expect(Location.count).to eq location_count + 1
      expect(LocationUser.count).to eq location_users_count + 1
    end

    it "redirect to the show template" do
      sign_in user
      post :create, params: {location: {latitude: 5,longitude: 6,shared_user_ids: ["",user1.id]}}
      expect(response).to redirect_to("/locations/#{assigns(:location).id}")
    end


    it "redirect to the new template" do
      sign_in user
      post :create, params: {location: {latitude: -405,longitude: 6,shared_user_ids: ["",user1.id]}}
      expect(response).to render_template "new"
    end
  end
end
