

Devise.setup do |config|
  require 'devise/orm/active_record'

  config.mailer_sender = 'no-reply@example.com'

  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.password_length = 6..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.stretches = Rails.env.test? ? 1 : 12

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete

  config.jwt do |jwt|
    jwt.secret = Rails.application.secret_key_base
    jwt.dispatch_requests = [
      ['POST', %r{^/users/sign_in$}]
    ]
    jwt.revocation_requests = [
      ['DELETE', %r{^/users/sign_out$}]
    ]
    jwt.expiration_time = 1.day.to_i
  end
end