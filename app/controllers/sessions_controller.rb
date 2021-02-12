class SessionsController < ApplicationController

  def omniauth
    # provider = auth['provider']
    # name = auth['omniauth.auth']['info']['name']
    user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.username = auth['info']['name']
      u.email = auth['info']['email']
      u.image = auth['info']['image']
      u.password = SecureRandom.hex(16)
    end

    session[:user_id] = @user.id
    render 'welcome/home'
  
  end

  private

  def auth
    request.env['omniauth.auth']
  end
end
