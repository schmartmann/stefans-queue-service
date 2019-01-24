require 'rails_helper'

RSpec.describe 'GET /policies', type: :request do
  let( :policy )  { Fabricate( :policy ) }
  let( :user )    { policy.user }
  let( :url )     { '/policies' }

  context 'when params are correct' do
    before do
      get url, headers: auth_headers( user )
    end

    it 'returns 200' do
      expect( response ).to have_http_status( 200 )
    end

    it 'returns one policy' do
      expect( json.first ).to match_schema( 'policy' )
    end
  end
end

RSpec.describe 'GET /policies/:uuid', type: :request do
  let( :policy )  { Fabricate( :policy ) }
  let( :user )    { policy.user }
  let( :uuid )    { policy.uuid }
  let( :url )     { "/policies/#{ uuid }" }

  context 'when params are correct' do
    before do
      get url, headers: auth_headers( user )
    end

    it 'returns 200' do
      expect( response ).to have_http_status( 200 )
    end

    it 'returns one policy' do
      expect( json.first ).to match_schema( 'policy' )
    end
  end
end

RSpec.describe 'POST /policies', type: :request do
  let( :user )  { Fabricate( :user ) }
  let( :kyoo )  { Fabricate( :kyoo ) }
  let( :url )   { '/policies' }
  let( :params ) do
    {
      policy: {
        user_id: user.id,
        kyoo_id: kyoo.id
      }
    }.to_json
  end

  context 'when params are correct' do
    before do
      post url, params: params, headers: auth_headers( user )
    end

    it 'returns 200' do
      expect( response ).to have_http_status( 200 )
    end

    it 'returns one policy' do
      expect( json ).to match_schema( 'policy' )
    end
  end

  context 'when user_id is missing' do
    before do
      params = {
        policy: {
          kyoo_id: nil
        }
      }.to_json

      post url, params: params, headers: auth_headers( user )
    end

    it 'returns 400' do
      expect( response ).to have_http_status( 400 )
    end

    it 'returns validation errors' do
      expect( json[ 'errors' ].first[ 'title' ] ).to eq( 'Bad Request' )
    end

    it 'returns correct error message' do
      error = json[ 'errors' ].first
      expect( error[ 'detail' ][ 'kyoo_id' ] ).to include( 'can\'t be blank' )
      expect( error[ 'detail' ][ 'kyoo' ] ).to include( 'must exist' )
    end
  end
end

RSpec.describe 'DELETE /policies/:uuid', type: :request do
  let( :policy )  { Fabricate( :policy ) }
  let( :user )    { policy.user }
  let( :uuid )    { policy.uuid }
  let( :url )     { "/policies/#{ uuid }" }

  context 'when params are correct' do
    before do
      delete url, headers: auth_headers( user )
    end

    it 'returns 204' do
      expect( response ).to have_http_status( 204 )
    end

    it 'returns no record' do
      expect( response.body ).to eq( '' )
    end

    it 'deletes the policy' do
      modified_policy = Policy.where( user_id: user.id )
      expect( modified_policy ).to eq( [] )
    end

    it 'deletes user\'s access to kyoo' do
      binding.pry
    end
  end
end
