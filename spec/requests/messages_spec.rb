require 'rails_helper'

RSpec.describe 'GET /kyoos/:kyoo_uuid/messages', type: :request do
  let( :message )   { Fabricate( :message ) }
  let( :user )      { message.kyoo.users.first }
  let( :kyoo_uuid ) { message.kyoo.uuid }
  let( :url )       { "/kyoos/#{ kyoo_uuid }/messages" }

  context 'when params are correct' do
    before do
      get url, headers: auth_headers( user )
    end

    it 'returns 200' do
      expect( response ).to have_http_status( 200 )
    end

    it 'returns one message' do
      expect( json.first ).to match_schema( 'message' )
    end
  end

  context 'when messages have mixed read states' do
    before do
      kyoo      = Fabricate( :kyoo_with_messages )
      user      = kyoo.users.first
      kyoo_uuid = kyoo.uuid
      url       = "/kyoos/#{ kyoo_uuid }/messages"

      get url, headers: auth_headers( user )
    end

    it 'returns 200' do
      expect( response ).to have_http_status( 200 )
    end

    it 'returns array of messages' do
      json.each do | message |
        expect( message ).to match_schema( 'message' )
      end
    end

    it 'scopes messages by unread state' do
      read_state_array = json.pluck( 'read' )

      expect( read_state_array ).to_not include( true )
    end
  end
end

RSpec.describe 'GET /kyoos/:kyoo_uuid/messages/:uuid', type: :request do
  let( :message )    { Fabricate( :message ) }
  let( :user )       { message.kyoo.users.first }
  let( :uuid )       { message.uuid }
  let( :kyoo_uuid )  { message.kyoo.uuid }
  let( :url )        { "/kyoos/#{ kyoo_uuid }/messages/#{ uuid }" }

  context 'when params are correct' do
    before do
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
  let( :message )    { Fabricate( :message ) }
  let( :kyoo_uuid )  { message.kyoo.uuid }
  let( :user )       { message.kyoo.users.first }
  let( :url )        { "/kyoos/#{ kyoo_uuid }/messages" }
  let ( :params ) do
    {
      message: {
        message_body: "{\"hello\":\"world\"}"
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

    it 'returns new message' do
      expect( json ).to match_schema( 'message' )
    end
  end

  context 'when message_body is missing' do
    before do
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

RSpec.describe 'DELETE /kyoos/:kyoo_uuid/messages/:uuid', type: :request do
  let( :message )    { Fabricate( :message ) }
  let( :kyoo_uuid )  { message.kyoo.uuid }
  let( :uuid )       { message.uuid }
  let( :user )       { message.kyoo.users.first }
  let( :url )        { "/kyoos/#{ kyoo_uuid }/messages/#{uuid }" }

  context 'when params are correct' do
    before do
      delete url, headers: auth_headers( user )
    end

    it 'returns 204' do
      expect( response ).to have_http_status( 204 )
    end

    it 'deletes the message' do
      modified_message = Message.where( uuid: uuid )

      expect( modified_message ).to eq( [] )
    end
  end

  context 'when uuid param is incorrect' do
    before do
      url = "/kyoos/#{ kyoo_uuid }/messages/#{ 'blip_blop' }"

      delete url, headers: auth_headers( user )
    end

    it 'returns 400' do
      expect( response ).to have_http_status( 400 )
    end
  end
end
