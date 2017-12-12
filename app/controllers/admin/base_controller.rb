class Admin::BaseController < ApplicationController
  before_action :current_user, :ensure_admin_can_access

  protected

  def ensure_admin_can_access
    unless @current_user.role == 'admin'
      respond_to do |format|
        format.html { redirect_to store_index_url, notice: 'You don\'t have privilege to access this section' }
      end
    end
  end

end
