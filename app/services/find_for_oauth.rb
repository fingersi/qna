class FindForOauth
  attr_reader :auth

  def initialize(auth)
    @auth = auth
  end

  def call
    authorization = OAuthProvider.where( provider: auth.provider, uid: auth.uid ).first
    return authorization&.user if authorization

    user = User.where(email: auth.info[:email]).first
    unless user
      password = SecureRandom.hex(10)
      user = User.create!(email: auth.info[:email], password: password, password_confirmation: password)
    end     
    user.oauthproviders.create(provider: auth.provider, uid: auth.uid)

    user
  end
end