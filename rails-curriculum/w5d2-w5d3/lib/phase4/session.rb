require 'json'
require 'webrick'

module Phase4
  class Session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      @req = req
      cookie = req.cookies.find { |cookie| '_rails_lite_app' == cookie.name }
      @cookie = cookie ? JSON.parse(cookie.value) : {}
    end

    def [](key)
      @cookie[key]
    end

    def []=(key, val)
      @cookie[key] = val
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      json_cookie = @cookie.to_json
      res.cookies << WEBrick::Cookie.new('_rails_lite_app', json_cookie)
    end
  end
end
