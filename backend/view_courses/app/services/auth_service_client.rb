# app/services/auth_service_client.rb
class AuthServiceClient < ApiClient
  def initialize
    super(ENV['AUTH_SERVICE_URL'] || 'http://authentication:3000')
  end

  def validate_token(token)
    get('/api/v1/validate_token', token: token)
  end

  def current_user(token)
    get('/api/v1/current_user', token: token)
  end
end