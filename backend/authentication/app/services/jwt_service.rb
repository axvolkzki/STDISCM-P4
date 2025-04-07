class JwtService
    # Use HMAC SHA256 algorithm for signing the JWT
    ALGORITHM = 'HS256'
    SECRET_KEY = Rails.application.credentials.secret_key_base || ENV['JWT_SECRET_KEY']


    # Method to encode the payload into a JWT
    def self.call(payload)
      payload[:exp] = Time.now.to_i + EXPIRATION_TIME
      JWT.encode(payload, SECRET_KEY, ALGORITHM)
    rescue JWT::EncodeError => e
      Rails.logger.error "JWT Encode Error: #{e.message}"
      nil
    end

    # Method to decode the JWT and return the payload
    def self.decode(token)
      decoded_token = JWT.decode(token, SECRET_KEY, true, { algorithm: ALGORITHM })
      decoded_token[0]
    rescue JWT::DecodeError => e
      Rails.logger.error "JWT Decode Error: #{e.message}"
      nil
    end
end