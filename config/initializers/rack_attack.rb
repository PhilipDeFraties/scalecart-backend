module Rack
  class Attack
    Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

    # Allow all local requests
    safelist('allow-localhost') do |req|
      req.ip == '127.0.0.1' || req.ip == '::1'
    end

    throttle('limit logins per email', limit: 5, period: 60) do |req|
      req.params['email'].to_s.downcase.gsub(/\s+/, "") if req.path == '/login' && req.post?
    end

    self.throttled_response = lambda do |_env|
      [429, { 'Content-Type' => 'application/json' }, [{ error: 'Too many login attempts. Please try again later.' }.to_json]]
    end
  end
end
