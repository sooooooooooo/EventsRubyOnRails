class ApplicationController < ActionController::Base
  before_action :require_login
  protect_from_forgery with: :exception

  def current_user
  	User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  private
  	def require_login
  		redirect_to "/" if !session[:user_id]
  	end
end
