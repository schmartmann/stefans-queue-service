require 'net/http'

module Dispatches
  class Dispatcher
    def initialize( endpoint_url, body )
      @url = URI.parse( endpoint_url )
      @body = body
    end

    def send
      begin
        response = http.request( dispatch_request )
        parse_response( response )
      rescue => error
        puts error
      end
    end

    private; def http
      http = Net::HTTP.new( @url.host, @url.port )
      http.read_timeout = 0.5
      http.use_ssl = check_ssl
      http
    end

    private; def dispatch_request
      request = Net::HTTP::Post.new( @url.path, { 'Content-Type': 'application/json' } )
      request.body = @body
      request
    end

    private; def check_ssl
      @url.scheme == 'https'
    end

    private; def json( body )
      JSON.parse( body ) rescue body
    end

    private; def parse_response( response )
      json( response.body )
    end
  end
end
