class JwtService
  ALGORITHM = 'HS256'
  SECRET_KEY = ENV.fetch('JWT_SECRET_KEY')
  DEFAULT_EXPIRATION = 15.minutes.to_i

  def self.encode(payload, exp = DEFAULT_EXPIRATION)
    payload = payload.dup
    payload[:iat] = Time.now.to_i
    payload[:exp] = Time.now.to_i + exp
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
