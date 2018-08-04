require 'rails_helper'

RSpec.describe 'links API' do

  describe 'POST create' do
    before {post '/api/links', params: params, xhr: true}

    context 'valid params' do
      let(:params) do
        {link: {url: 'test@applift.de'}}
      end

      it 'returns status :ok' do
        expect(response).to be_success
      end

      it 'returns json according the schema' do
        expect(response).to match_response_schema('link')
      end
    end

    context 'invalid params' do
      let(:params) do
        {link: {url: ''}}
      end

      it 'returns status 422' do
        expect(response.status).to eq 422
      end

      it 'returns errors messages' do
        expect(response.body).to eq "{\"url\":[\"can't be blank\"]}"
      end
    end
  end

  describe 'GET redirect' do
    describe 'the link is present in the db' do
      let!(:link) {create(:link, url: 'http://www.applift.de')}
      before {get '/api/links/redirect', params: {shortcode: link.shortcode}, xhr: true}

      it 'returns status 302' do
        expect(response.status).to eq 302
      end

      it 'returns redirect location in response headers' do
        expect(response.headers['Location']).to eq link.url
      end
    end

    describe 'a link is not present in the db' do
      before {get '/api/links/redirect', params: {shortcode: 'nocode'}, xhr: true}

      it 'returns status 404' do
        expect(response.status).to eq 404
      end

      it 'returns an empty response body' do
        expect(response.body).to be_empty
      end
    end
  end
end
