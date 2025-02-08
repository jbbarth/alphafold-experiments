Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"]
end
OmniAuth.config.allowed_request_methods = %i[get]

# Google SSL certs verification is broken on IPv6 + MacOS Sequoia (at least)
if RUBY_PLATFORM == "arm64-darwin24"
  OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
end
