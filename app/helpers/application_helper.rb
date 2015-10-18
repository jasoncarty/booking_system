module ApplicationHelper

  def avatar_url(user, size = nil)
    size.nil? ? size = 48 : size = size
    default_url = "#{root_url}images/guest.png"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=wavatar"
  end

  def active_link?(link)
    request.original_url == link ? 'active' : ''
  end

end
