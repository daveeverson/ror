require 'authorization_exception'

class ApplicationController < ActionController::Base
  layout("intranet")
  #OIDC_FLOW_START = "#{ENV['RAILS_RELATIVE_URL_ROOT']}/auth/extranet"

  helper :all # include all helpers, all the time
  helper_method :current_user
  before_filter :authenticate #, except: [:authentication_callback, :not_authorized]

  def authentication_callback
    auth = request.env["omniauth.auth"]
    username = auth.dig("extra","raw_info","sam_account_name")
    policy = auth.dig("extra","raw_info","policies")&.keys&.first
    authorize(username, policy)
    redirect_to session[:return_to] || root_path 
  rescue AuthorizationException => _e
    redirect_to application_not_authorized_path 
  end

  def not_authorized; end

  def logout
    reset_session
  end

  private

  def authorize(username, policy)
    user = AuthorizedUser.new(username, policy)
    session[:user] = user
  rescue => e
    raise AuthorizationException, e.message
  end

  def authenticate
    return true
    #return true if current_user.present?

    session[:return_to] = request.fullpath if request.get?
    # redirect_to OIDC_FLOW_START

    #stub username to be looked up in AD with 'Admin' policy here
    username = 'filastna' # example for user First Lastname
    policy = 'Admin'
    authorize(username, policy)
  end

  def current_user
    session[:user]
  end

  class AuthorizationException < StandardError; end;
end
