class Admin::ApiKeysController < ApplicationController
  before_action :authenticate_admin
  def index
    @api_keys = ApiKey.all
  end

  private

  def authenticate_admin
    redirect_to unauthenticated_root_path unless user_logged_in && current_user.admin?
  end
end
