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
  end
end
