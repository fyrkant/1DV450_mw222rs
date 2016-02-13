class Admin::ApiKeysController < ApplicationController
  before_action :authenticate_admin
  def index
    @api_keys = ApiKey.all.search(params[:keyword])
  end

  def new

  end

  def edit
  end

  def destroy
  end

  private

  def authenticate_admin
    redirect_to unauthenticated_root_path unless user_signed_in? && current_user.admin?
  end
end
