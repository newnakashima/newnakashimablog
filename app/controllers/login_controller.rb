class LoginController < ApplicationController
  include ApplicationHelper
  def index
  end

  def login
    pass = md5_hash(params[:pass]).to_s
    user = getUser(params[:name])
    if login?(user, params[:pass])
      session[:login_info] = {
        :name => user.name,
        :login? => true,
      }
      user.update(last_login: Time.now)
    else
      render 'index'
    end
  end
  
  def logout
    if loggedIn?
      session[:login_info] = nil
      session[:logged_out] = true
    end
    render 'index'
  end
end
