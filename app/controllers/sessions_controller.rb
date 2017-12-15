class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
  end

  def create
    user = User.find_by(name: params[:name])
    if user.try(:authenticate, params[:password])
      session[:user_id] = user.id
      session[:last_activity_time] = Time.current
      session[:url_view_counter] = Hash.new(0)
      I18n.locale = user.language
      redirect_to user.role == 'admin' ? admin_reports_path : users_orders_path
    else
      redirect_to login_url, alert: "Invalid user/password combination"
    end
  end

  def destroy
    clear_session
  end
end
