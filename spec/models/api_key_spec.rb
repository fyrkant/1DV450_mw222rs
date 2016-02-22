require "rails_helper"

RSpec.describe ApiKey, type: :model do
  let(:user) { User.create!(email: "test@mail.com", password: "testpass", password_confirmation: "testpass") }
  it { should validate_presence_of :name }
  it { should belong_to :user }

  it "should not have a key before save" do
    api_key = ApiKey.new
    api_key.name = "Cool app"
    api_key.user = user

    expect(api_key).not_to have_attributes(key: String)
  end

  it "creates key on before creation" do
    api_key = ApiKey.new
    api_key.name = "Cool app"
    api_key.user = user
    api_key.save

    expect(api_key).to have_attributes(key: String)
  end

  it "should not change key with name change" do
    api_key = ApiKey.new
    api_key.name = "Cool app"
    api_key.user = user
    api_key.save

    first_key = api_key.key

    api_key.name = "A new name"
    api_key.save

    expect { api_key.save }.not_to change { api_key.key }.from(first_key)
  end
end
