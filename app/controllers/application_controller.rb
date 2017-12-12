class ApplicationController < ActionController::Base
  before_action :authorize
  before_action :set_i18n_locale_from_params
  protect_from_forgery with: :exception
  before_action :current_user, only: [:show_user_orders, :show_user_line_items]
  before_action :increment_view_counter
  around_action :add_custom_header
  before_action :check_for_inactivity


  protected

    def authorize
      unless User.find_by(id: session[:user_id])
        redirect_to login_url, notice: "Please log in"
      end
    end

    def set_i18n_locale_from_params
      if params[:locale]
        if I18n.available_locales.map(&:to_s).include?(params[:locale])
          I18n.locale = params[:locale]
        else
          flash.now[:notice] = "#{ params[:locale] } translation not available "
          logger.error flash.now[:notice]
        end
      end
    end

    def current_user
      if session[:user_id]
        @current_user ||= User.find(session[:user_id])
      end
    end

    def increment_view_counter
      current_user
      if @current_user
        session[:url_view_counter][request.path] ||= 0
        session[:url_view_counter][request.path] += 1
      end
    end

    def add_custom_header
      start = Time.current
      yield
      duration = start - Time.current
      response.headers[" #{ request.path } responsed in"] = duration
    end

    def check_for_inactivity
      if @current_user
        if Time.now - session[:last_activity_time].to_time > 1.minutes
          session.clear
          redirect_to store_index_url, notice: "Logged out due to inactivity"
        else
          session[:last_activity_time] = Time.now
        end
      end
    end
end
