module ApplicationHelper
  def nl2br(str)
    return sanitize(str).gsub("\n", "<br>").html_safe
  end

  def md5_hash(phrase)
    return Digest::MD5.new.update(phrase.to_s)
  end

  def getUser(user_name)
    return User.find_by(name: user_name)
  end

  def login?(user, pass)
    if user != nil
      return md5_hash(pass).to_s == user.pass
    else
      return false
    end
  end

  def loggedIn?
    result = !session[:login_info].nil? || !defined? session[:login_info]
    puts result
    return result
  end

end
