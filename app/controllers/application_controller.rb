class ApplicationController < ActionController::Base

  # Make the function become a helper that can be used on view
  helper_method :current_user, :logged_in?
  def current_user
    # ||= explanation
    # If use this, the @current_user will only initialize once so the system does not need to
    # re-query using User.find, make lighter for the server
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # !! -- Converts value to a boolean
    !!current_user
  end

end
