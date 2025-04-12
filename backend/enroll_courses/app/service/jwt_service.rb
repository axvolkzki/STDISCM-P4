class JwtService
  ALGORITHM = 'HS256'
  SECRET_KEY = ENV.fetch('JWT_SECRET_KEY') # Require this to be set
  EXPIRATION_TIME = 24.hours.to_i

  def self.encode(payload) # Better name than 'call'
    payload = payload.dup
    payload[:exp] = Time.now.to_i + EXPIRATION_TIME
    JWT.encode(payload, SECRET_KEY, ALGORITHM)
  rescue JWT::EncodeError => e
    Rails.logger.error "JWT Encode Error: #{e.message}"
    nil
  end

  def self.decode(token)
    JWT.decode(token, SECRET_KEY, true, { 
      algorithm: ALGORITHM,
      verify_expiration: true 
    }).first
  rescue JWT::ExpiredSignature
    Rails.logger.error "JWT Expired"
    nil
  rescue JWT::DecodeError => e
    Rails.logger.error "JWT Decode Error: #{e.message}"
    nil
  end
end