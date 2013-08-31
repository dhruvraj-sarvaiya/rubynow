class SessionsController < ApplicationController	

  def new
  end

  	def create
    	user = User.find_by_email(params[:session][:email].downcase)
    	if user && user.authenticate(params[:session][:password])
      		sign_in user
      		#redirect_back_or user
          redirect_to(root_path)
    	else
      		flash.now[:error] = 'Invalid email/password combination'
      		render 'new'
    	end
  	end

  	def destroy
  		sign_out
    	redirect_to root_url
  	end

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    #@current_user ||= User.find_by(remember_token: remember_token)
     @current_user ||= User.find_by_remember_token(remember_token)
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
  
  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    #session.delete(:return_to)
    session.delete[:return_to]
  end

  def store_location
    session[:return_to] = request.url
  end
  

end
