class SessionsController < ApplicationController
  def create
    @auth = Authorization.find_or_create_from_auth_hash(auth, current_user)

    # TODO: Handle not found
    self.current_user = @auth.user

    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
