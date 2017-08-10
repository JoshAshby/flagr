class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  protected

  def current_user
    @current_user ||= User.find_by id: session[:user_id]
  end

  def signed_in?
    current_user.present?
  end

  helper_method :current_user, :signed_in?

  def current_user= user
    @current_user = user
    session[:user_id] = user.id
  end
end
