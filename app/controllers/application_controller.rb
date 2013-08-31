class ApplicationController < ActionController::Base
  protect_from_forgery
  #include SessionsHelper
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  #protect_from_forgery # :secret => '526292d4095d0fd8135a9aa118f5956e'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  def current_cart
    session[:cart_id] ||= Cart.create!.id
    @current_cart ||= Cart.find(session[:cart_id])
  end

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end
end
