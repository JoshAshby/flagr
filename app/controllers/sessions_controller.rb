class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  # https://seesparkbox.com/foundry/simulating_social_login_with_omniauth
  def create
    @auth = Authorization.find_or_create_from_auth_hash(auth_hash, user: current_user)

    # TODO: Handle not found
    self.current_user = @auth.user

    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
