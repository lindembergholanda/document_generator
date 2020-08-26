class ApplicationController < ActionController::Base
     before_action :authenticate_user!, except: [:validation]
     before_action :set_locale
     protect_from_forgery with: :null_session

     add_breadcrumb I18n.t("breadcrumbs.home"), :root_path

     def set_locale
          begin
               if params[:locale].present?
                    raise I18n.t('messages.unsupported_locale') unless ['pt-BR', 'en'].include?(params[:locale]) 
                    session[:locale] = params[:locale] 
               end
               I18n.locale = session[:locale] 
          rescue => e
               flash[:warning] = e.message
          end
          redirect_back(fallback_location: root_path) if params[:locale].present?
     end
end
