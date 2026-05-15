module OmniauthMacros
  def mock_github_user(uid: '12345', email: 'user@example.com')
    OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new({
      provider: 'github',
      uid: uid,
      info: {
        email: email,
      }
    })
  end
end