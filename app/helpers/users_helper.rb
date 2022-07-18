module UsersHelper
  def gravatar_for(user)
    email_address = user.email.downcase
    hash = Digest::MD5.hexdigest(email_address)
    image_src = "https://www.gravatar.com/avatar/#{hash}?s=128"
    image_tag(image_src, alt: user.username, class: "rounded shadow-sm")
  end
end
