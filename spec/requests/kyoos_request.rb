require 'rails_helper'

RSpec.describe 'GET /kyoos', type: :request do
  let( :kyoo ) { Fabricate( :kyoo ) }
  let( :url ) { '/kyoos' }

  context 'when params are correct' do
    before do
      get url
    end

    it 'returns 200' do
      binding.pry
      expect( response ).to have_http_status( 200 )
    end
  end
end
