require "rails_helper"

RSpec.describe ApiKeysController, type: :routing do
  describe "routing" do
    xcontext "as unauthorized user" do
      it "redirects to sign in page" do
        expect(get: "/api_keys").to route_to("api_key#index")
      end
    end

    context "as authorized user" do
      before(:each) do
        user = User.create!(email: "test@mail.com", password: "testpass", password_confirmation: "testpass")
        post user_session_path, user: { email: user.email, password: user.password }
      end

      it "routes to #index" do
        expect(get: "/api_keys").to route_to("api_keys#index")
      end

      it "routes to #new" do
        expect(get: "/api_keys/new").to route_to("api_keys#new")
      end

      it "routes to #show" do
        expect(get: "/api_keys/1").to route_to("api_keys#show", id: "1")
      end

      it "routes to #edit" do
        expect(get: "/api_keys/1/edit").to route_to("api_keys#edit", id: "1")
      end

      it "routes to #create" do
        expect(post: "/api_keys").to route_to("api_keys#create")
      end

      it "routes to #update via PUT" do
        expect(put: "/api_keys/1").to route_to("api_keys#update", id: "1")
      end

      it "routes to #update via PATCH" do
        expect(patch: "/api_keys/1").to route_to("api_keys#update", id: "1")
      end

      it "routes to #destroy" do
        expect(delete: "/api_keys/1").to route_to("api_keys#destroy", id: "1")
      end
    end
  end
end
