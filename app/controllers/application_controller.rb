class ApplicationController < ActionController::Base
  before_action :authorize
  before_action :set_i18n_locale_from_params
  protect_from_forgery with: :exception
  before_action :current_user, only: [:show_user_orders, :show_user_line_items]

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
      @current_user ||= User.find(session[:user_id])
    end

end
