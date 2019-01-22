require 'rails_helper'

RSpec.describe 'POST /signup', type: :request do
  let( :url ) { '/signup' }
  let( :params ) do
    {
      user: {
        email: 'user@example.com',
        password: 'assw0rd'
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
      Fabricate( :user, email: params[ :user][ :email ] )
      post url, params: params
    end

    it 'returns 400' do
      expect( response.status ).to eq( 400 )
    end

    it 'returns validation errors' do
      expect( json[ 'errors' ].first[ 'title'] ).to eq( 'Bad Request' )
    end
  end
end
