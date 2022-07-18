module ApplicationHelper
  def gravatar_for(user, options: {size: 80})
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    size = options[:size]
    image_src = "https://www.gravatar.com/avatar/#{hash}?s=#{size}"
    image_tag(image_src, alt: user.username, class: "rounded shadow-sm")
  end

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
