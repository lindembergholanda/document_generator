class ApplicationController < ActionController::Base
     before_action :authenticate_user!, except: [:validation]
     protect_from_forgery with: :null_session
end
