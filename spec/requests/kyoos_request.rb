require 'rails_helper'

RSpec.describe 'GET /kyoos', type: :request do
  let( :user )   { Fabricate( :user ) }
  let( :kyoo )   { Fabricate( :kyoo ) }
  let( :url )    { '/kyoos' }

  context 'authenticated' do
    context 'when params are correct' do
      before do
        Fabricate( :policy, user: user, kyoo: kyoo )

        get url, headers: auth_headers( user )
      end

      it 'returns 200' do
        expect( response ).to have_http_status( 200 )
      end

      it 'returns a kyoo array' do
        expect( json.first ).to match_schema( 'kyoo' )
      end
    end
  end

  context '!authenticated' do
    before do
      get url, headers: nil
    end

    it 'returns 401' do
      expect( response ).to have_http_status( 401 )
    end
  end
end

RSpec.describe 'GET /kyoos/:uuid', type: :request do
  let( :kyoo )   { Fabricate(:kyoo ) }
  let( :user )   { Fabricate( :user ) }
  let( :uuid )   { kyoo.uuid }
  let( :url )    { "/kyoos/#{ uuid }" }

  context 'when params are correct' do
    before do
      Fabricate( :policy, user: user, kyoo: kyoo )

      get url, headers: auth_headers( user )
    end

    it 'returns 200' do
      expect( response ).to have_http_status( 200 )
    end

    it 'returns one kyoo' do
      expect( json.first ).to match_schema( 'kyoo' )
    end
  end
end

RSpec.describe 'POST /kyoos', type: :request do
  let( :user )  { Fabricate( :user ) }
  let( :url )   { '/kyoos' }
  let( :params ) do
    {
      kyoo: {
        name: "#{ Faker::TheThickOfIt.department }"
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

    it 'returns new kyoo' do
      expect( json ).to match_schema( 'kyoo' )
    end
  end

  context 'when name is missing' do
    before do
      kyoo = {
        kyoo: {
          name: nil
        }
      }.to_json

      post url, params: kyoo, headers: auth_headers( user )
    end

    it 'returns 400' do
      expect( response ).to have_http_status( 400 )
    end

    it 'returns validation errors' do
      expect( json[ 'errors' ].first[ 'title' ] ).to eq( 'Bad Request' )
    end

    it 'returns correct error message' do
      error = json[ 'errors' ].first

      expect( error[ 'detail' ][ 'name' ] ).to include(
        'can\'t be blank',
      )
    end
  end

  context 'when kyoo already exists' do
    before do
      already_taken_name = JSON.parse( params )[ "kyoo" ][ "name" ]

      Fabricate( :kyoo, name: already_taken_name )

      post url, params: params, headers: auth_headers( user )
    end

    it 'returns 400' do
      expect( response ).to have_http_status( 400 )
    end

    it 'returns correct error message' do
      error = json[ 'errors' ].first

      expect( error[ 'detail' ][ 'name' ] ).to include(
        'has already been taken',
      )
    end
  end
end
