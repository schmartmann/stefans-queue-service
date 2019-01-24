require 'rails_helper'

RSpec.describe 'GET /kyoos/:kyoo_uuid/messages', type: :request do
  let( :user )      { Fabricate( :user ) }
  let( :kyoo )      { Fabricate( :kyoo ) }
  let( :kyoo_uuid ) { kyoo.uuid }
  let( :url )       { "/kyoos/#{ kyoo_uuid }/messages" }

  context 'when params are correct' do
    before do
      Fabricate( :message, kyoo: kyoo )
      Fabricate( :policy, user: user, kyoo: kyoo )

      get url, headers: auth_headers( user )
    end

    it 'returns 200' do
      expect( response ).to have_http_status( 200 )
    end

    it 'returns one message' do
      expect( json.first ).to match_schema( 'message' )
    end
  end
end

RSpec.describe 'GET /kyoos/:kyoo_uuid/messages/:uuid', type: :request do
  let( :user )      { Fabricate( :user ) }
  let( :kyoo )      { Fabricate( :kyoo ) }
  let( :kyoo_uuid ) { kyoo.uuid }

  context 'when params are correct' do
    before do
      message = Fabricate( :message, kyoo: kyoo )

      Fabricate( :policy, user: user, kyoo: kyoo )

      url = "/kyoos/#{ kyoo_uuid }/messages/#{ message.uuid }"

      get url, headers: auth_headers( user )
    end

    it 'returns 200' do
      expect( response ).to have_http_status( 200 )
    end

    it 'returns one message' do
      expect( json.first ).to match_schema( 'message' )
    end
  end
end

RSpec.describe 'POST /kyoos/:kyoo_uuid/messages', type: :request do
  let( :user )  { Fabricate( :user ) }
  let( :kyoo )      { Fabricate( :kyoo ) }
  let( :kyoo_uuid ) { kyoo.uuid }
  let( :url )   { "/kyoos/#{ kyoo_uuid }/messages" }

  context 'when params are correct' do
    before do
      Fabricate( :policy, user: user, kyoo: kyoo )

      params = {
        message: {
          message_body: "{\"hello\":\"world\"}"
        }
      }.to_json


      post url, params: params, headers: auth_headers( user )
    end

    it 'returns 200' do
      expect( response ).to have_http_status( 200 )
    end

    it 'returns new message' do
      expect( json ).to match_schema( 'message' )
    end
  end

  context 'when message_body is missing' do
    before do
      Fabricate( :policy, user: user, kyoo: kyoo )

      message = {
        message: {
          message_body: nil
        }
      }.to_json

      post url, params: message, headers: auth_headers( user )
    end

    it 'returns 400' do
      expect( response ).to have_http_status( 400 )
    end

    it 'returns validation errors' do
      expect( json[ 'errors' ].first[ 'title' ] ).to eq( 'Bad Request' )
    end

    it 'returns correct error message' do
      error = json[ 'errors' ].first

      expect( error[ 'detail' ][ 'message_body' ] ).to include(
        'can\'t be blank',
      )
    end
  end
end
