require 'jwt'

class JsonWebToken
  SECRET_KEY = ENV.fetch('JWT_SECRET_KEY')

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    decoded = JWT.decode(token, SECRET_KEY, true, algorithm: 'HS256')
    decoded.first
  rescue JWT::DecodeError
    nil
  end
end