require 'jwt'

class JsonWebToken
  SECRET_KEY = ENV.fetch('JWT_SECRET_KEY')
  ALGORITHM = 'HS256'.freeze

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    payload[:jti] = SecureRandom.uuid
    JWT.encode(payload, SECRET_KEY, ALGORITHM)
  end

  def self.decode(token)
    body = JWT.decode(token, SECRET_KEY, true, algorithm: ALGORITHM)[0]
    return nil if body['exp'].to_i < Time.now.to_i
    return nil if body['jti'].nil? || JwtDenylist.exists?(jti: body['jti'])

    HashWithIndifferentAccess.new(body)
  rescue JWT::ExpiredSignature, JWT::DecodeError
    nil
  end
end
