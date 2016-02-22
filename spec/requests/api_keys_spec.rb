require "rails_helper"

RSpec.describe "ApiKeys", type: :request do
  describe "GET /api_keys" do
    context "as an unauthorized user" do
      it "redirects to sign in page" do
        get api_keys_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "as an authorized user" do
      before do
        user = User.create!(email: "test@mail.com", password: "testpass", password_confirmation: "testpass")
        post user_session_path, user: { email: user.email, password: user.password }
      end

      it "doesn't redirect" do
        get api_keys_path
        expect(response).to have_http_status(:ok)
      end
    end
    context "as an admin user" do
      before do
        user = User.create!(
          email: "test@mail.com", password: "testpass", password_confirmation: "testpass", admin: true)
        post user_session_path, user: { email: user.email, password: user.password }
      end

      it "redirects to admin namespace" do
        get api_keys_path
        expect(response).to redirect_to(admin_api_keys_path)
      end
    end
  end
end
