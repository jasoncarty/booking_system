module ApplicationHelper

  def avatar_url(user, size = nil)
    size.nil? ? size = 48 : size = size
    default_url = "#{root_url}images/guest.png"
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}&d=wavatar"
  end

  def admin?
    @current_user.role == 'admin' ? true : false
  end

  def active_link?(link)
    current_page?(link) ? 'active' : ''
  end

  def generate_token
    token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end  

end
