require 'rails_helper'

RSpec.describe 'GET /kyoos', type: :request do
  let( :user )   { Fabricate( :user ) }
  let( :kyoo )   { Fabricate( :kyoo ) }
  let( :policy ) { Fabricate( :policy, kyoo: kyoo, user: user ) }
  let( :url )    { '/kyoos' }

  context 'authenticated' do
    context 'when params are correct' do
      before do
        get url, headers: auth_headers( user )
      end

      it 'returns 200' do
        expect( response ).to have_http_status( 200 )
      end

      it 'returns a kyoo' do
        expect( response.body.first ).to match_schema( 'kyoo' )
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
  let( :user )   { Fabricate( :user ) }
  let( :kyoo )   { Fabricate( :kyoo ) }
  let( :policy ) { Fabricate( :policy, kyoo: kyoo, user: user ) }
  let( :uuid )   { kyoo.uuid }
  let( :url )    { "/kyoos/#{ uuid }" }

  context 'authenticated' do
    context 'when params are correct' do
      before do
        binding.pry
        get url, headers: auth_headers( user )
      end

      it 'returns 200' do
        expect( response ).to have_http_status( 200 )
      end

      it 'returns a kyoo' do
        expect( response.body ).to match_schema( 'kyoo' )
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

    it 'doesn\'t return a kyoo' do
      expect( response.body ).to eq( 'You need to sign in or sign up before continuing.' )
    end
  end
end
