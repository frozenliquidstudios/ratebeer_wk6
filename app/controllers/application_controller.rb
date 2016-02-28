class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :currently_signed_in?

  def current_user
    return nil if session[:user_id].nil?
    User.find(session[:user_id])
  end
	
  def currently_signed_in?(user)
    current_user == user
  end
  
  def ensure_that_signed_in
    redirect_to signin_path, notice:'you should be signed in' if current_user.nil?
  end
  
  def ensure_that_admin
    render text: "You need to be an admin.", status: 500 unless current_user and current_user.admin
  end
end
