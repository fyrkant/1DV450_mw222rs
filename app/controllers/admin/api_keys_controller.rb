class Admin::ApiKeysController < ApplicationController
  before_action :authenticate_admin
  before_action :set_api_keys, only: :destroy

  def index
    @api_keys = ApiKey.includes(:user)
                      .search(params[:keyword])
                      .filter(params[:filter])
  end

  def search
    render json: ApiKey.search(params[:term]).pluck(:name)
  end

  def destroy
    @api_key.destroy
    respond_to do |format|
      format.html { redirect_to admin_api_keys_url, notice: "API key for \"#{@api_key.name}\" was successfully revoked." }
      format.json { head :no_content }
    end
  end

  private

  def authenticate_admin
    redirect_to unauthenticated_root_path unless user_signed_in? && current_user.admin?
  end

  # Use callbacks to share common setup or constraints between actions.

  def set_api_keys
    @api_key = ApiKey.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.

  def api_key_params
    params.require(:api_key).permit(:name, :key)
  end
end
