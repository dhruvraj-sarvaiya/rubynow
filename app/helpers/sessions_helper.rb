module SessionsHelper
	  def sign_in(user)
    	cookies.permanent[:remember_token] = user.remember_token
    	self.current_user = user
      #raise user.remember_token
      # remember_token = User.new_remember_token
      # cookies.permanent[:remember_token] = remember_token
      # #user.update_attribute(:remember_token, remember_token)
      # user.remember_token = remember_token
      # user.save
      # self.current_user = user
      #raise "#{'remember_token:'}#{remember_token} #{'cookies:'}#{cookies[:remember_token]} #{'user:'}#{user.remember_token.inspect}"
  	end

  	def signed_in?
	    !current_user.nil?
	  end

  	def current_user=(user)
	    @current_user = user
	  end

  	def current_user   		
   		@current_user ||= User.find_by_remember_token(cookies[:remember_token])
  	end

  	# def current_user?(user)
	  #   user == current_user
	  # end

  	def sign_out
	    self.current_user = nil
	    cookies.delete(:remember_token)
      current_user = nil
      #raise self.current_user.inspect
	  end

	  def redirect_back_or(default)
    	redirect_to(session[:return_to] || default)
    	session.delete(:return_to)
  	end

  	def store_location
   	 session[:return_to] = request.url
  	end  	

    def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end
end
