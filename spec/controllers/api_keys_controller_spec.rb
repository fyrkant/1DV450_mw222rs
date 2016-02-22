require "rails_helper"

RSpec.describe ApiKeysController, type: :controller do
  context "as unauthorized user" do
  end

  context "as authorized user" do
    let(:user) { User.create!(email: "test@mail.com", password: "testpass", password_confirmation: "testpass") }
    subject { user }
    before { sign_in user }

    let(:valid_attributes) { { name: "Cool name", user: user } }

    let(:invalid_attributes) { { name: nil } }

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # ApiKeysController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe "GET #index" do
      it "assigns all api_keys as @api_keys" do
        api_key = ApiKey.create! valid_attributes
        get :index, {}, valid_session
        expect(assigns(:api_keys)).to eq([api_key])
      end
    end

    describe "GET #show" do
      it "throws UrlGenerationError" do
        api_key = ApiKey.create! valid_attributes
        expect do
          get :show, { id: api_key.to_param }, valid_session
        end.to raise_error(ActionController::UrlGenerationError)
      end
    end

    describe "GET #new" do
      it "assigns a new api_key as @api_key" do
        get :new, {}, valid_session
        expect(assigns(:api_key)).to be_a_new(ApiKey)
      end
    end

    describe "GET #edit" do
      it "assigns the requested api_key as @api_key" do
        api_key = ApiKey.create! valid_attributes
        get :edit, { id: api_key.to_param }, valid_session
        expect(assigns(:api_key)).to eq(api_key)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new ApiKey" do
          expect do
            post :create, { api_key: valid_attributes }, valid_session
          end.to change(ApiKey, :count).by(1)
        end

        it "assigns a newly created api_key as @api_key" do
          post :create, { api_key: valid_attributes }, valid_session
          expect(assigns(:api_key)).to be_a(ApiKey)
          expect(assigns(:api_key)).to be_persisted
        end

        it "redirects to the created api_key" do
          post :create, { api_key: valid_attributes }, valid_session
          expect(response).to redirect_to(ApiKey.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved api_key as @api_key" do
          post :create, { api_key: invalid_attributes }, valid_session
          expect(assigns(:api_key)).to be_a_new(ApiKey)
        end

        it "re-renders the 'new' template" do
          post :create, { api_key: invalid_attributes }, valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) { { name: "New name" } }

        it "updates the requested api_key" do
          api_key = ApiKey.create! valid_attributes
          put :update, { id: api_key.to_param, api_key: new_attributes }, valid_session
          api_key.reload
          expect(api_key.name).to eq("New name")
        end

        it "assigns the requested api_key as @api_key" do
          api_key = ApiKey.create! valid_attributes
          put :update, { id: api_key.to_param, api_key: valid_attributes }, valid_session
          expect(assigns(:api_key)).to eq(api_key)
        end

        it "redirects to the root path" do
          api_key = ApiKey.create! valid_attributes
          put :update, { id: api_key.to_param, api_key: valid_attributes }, valid_session
          expect(response).to redirect_to(root_path)
        end
      end

      context "with invalid params" do
        it "assigns the api_key as @api_key" do
          api_key = ApiKey.create! valid_attributes
          put :update, { id: api_key.to_param, api_key: invalid_attributes }, valid_session
          expect(assigns(:api_key)).to eq(api_key)
        end

        it "re-renders the 'edit' template" do
          api_key = ApiKey.create! valid_attributes
          put :update, { id: api_key.to_param, api_key: invalid_attributes }, valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested api_key" do
        api_key = ApiKey.create! valid_attributes
        expect do
          delete :destroy, { id: api_key.to_param }, valid_session
        end.to change(ApiKey, :count).by(-1)
      end

      it "redirects to the api_keys list" do
        api_key = ApiKey.create! valid_attributes
        delete :destroy, { id: api_key.to_param }, valid_session
        expect(response).to redirect_to(api_keys_url)
      end
    end
  end
end
