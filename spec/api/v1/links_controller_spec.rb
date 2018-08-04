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
end
