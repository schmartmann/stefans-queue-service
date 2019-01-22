require 'rails_helper'

RSpec.describe 'POST /signup', type: :request do
  let( :url ) { '/signup' }
  let( :params ) do
    {
      user: {
        email: 'user@example.com',
        password: 'passw0rd'
      }
    }
  end

  context 'when user is unauthenticated' do
    before { post url, params: params }

    it 'returns 200' do
      expect( response.body ).to match_schema( 'user' )
    end

    it 'returns a new user' do
      expect( response.body ).to match_schema( 'user' )
    end
  end

  context 'when user already exists' do
    before do
      Fabricate( :user,
                  email: params[ :user][ :email ],
                  password: params[ :user ][ :password ]
                )

      post url, params: params
    end

    it 'returns 400' do
      expect( response.status ).to eq( 400 )
    end

    it 'returns validation errors' do
      expect( json[ 'errors' ].first[ 'title'] ).to eq( 'Bad Request' )
    end
  end

  context 'when user password is missing' do
    before do
      user = params[ :user ]
      post url, params: { user: { email: user[ :email ], password: nil  } }
    end

    it 'returns 400' do
      expect( response.status ).to eq( 400 )
    end

    it 'returns validation errors' do
      expect( json[ 'errors' ].first[ 'title'] ).to eq( 'Bad Request' )
    end

    it 'returns correct error message' do
      error = json[ 'errors' ].first

      expect( error[ 'detail' ][ 'password' ] ).to include(
        "can't be blank",
        'is too short (minimum is 8 characters)'
      )
    end
  end
end
