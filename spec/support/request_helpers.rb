module RequestHelpers
  def decoded_jwt_token_from_response( response )
    token = response.headers[ 'Authorization' ].split(' ').last
    hmac_secret = ENV[ 'DEVISE_JWT_SECRET_KEY' ]
    JWT.decode( token, hmac_secret, true )
  end
end
