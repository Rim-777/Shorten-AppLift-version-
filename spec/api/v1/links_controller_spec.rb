require 'rails_helper'

RSpec.describe 'links API' do
  describe 'POST create' do
    before { post '/api/links', params: params, xhr: true }

    context 'valid params' do
      let(:params) { { link: { url: 'test@applift.de' } } }

      it_behaves_like 'Success'

      it 'returns json according the schema' do
        expect(response).to match_response_schema('link')
      end
    end

    context 'invalid params' do
      let(:params) { { link: { url: '' } } }

      it 'returns status 422' do
        expect(response.status).to eq 422
      end

      it 'returns errors messages' do
        expect(response.body).to eq "{\"url\":[\"can't be blank\"]}"
      end
    end
  end

  describe 'GET redirect' do
    context 'the link is present in the db' do
      let!(:link) { create(:link, url: 'http://www.applift.de') }
      before { get '/api/links/redirect', params: { shortcode: link.shortcode }, xhr: true }

      it 'returns status 302' do
        expect(response.status).to eq 302
      end

      it 'returns redirect location in response headers' do
        expect(response.headers['Location']).to eq link.url
      end
    end

    context 'a link is not present in the db' do
      before { get '/api/links/redirect', params: { shortcode: 'nocode' }, xhr: true }

      it_behaves_like 'NotFound'

      it 'returns an empty response body' do
        expect(response.body).to be_empty
      end
    end
  end

  describe 'GET stats' do
    let!(:link) { create(:link, url: 'http://www.applift.de') }

    before do
      create_list(:link_click, 3, link: link, created_at: '2018/07/07 14:00'.to_datetime)
      create_list(:link_click, 2, link: link, created_at: '2018/07/10 14:00'.to_datetime)
      create_list(:link_click, 5, link: link, created_at: '2018/07/12 14:00'.to_datetime)
    end

    context 'some range is present' do
      let(:params) do
        {
            shortcode: link.shortcode,
            start_time: '2018/07/07 13:00',
            end_time: '2018/07/07 20:00'
        }
      end

      before { get '/api/links/stats', params: params, xhr: true }

      it_behaves_like 'Success'

      it 'returns stats with 3 clicks' do
        expect(response.body).to eq "{\"clicks\":3}"
      end
    end

    context 'a range is not present' do
      let(:params) { { shortcode: link.shortcode } }
      before { get '/api/links/stats', params: params, xhr: true }

      it_behaves_like 'Success'

      it 'returns stats with all clicks' do
        expect(response.body).to eq "{\"clicks\":10}"
      end
    end

    context 'a start-time is only present' do
      let(:params) { { shortcode: link.shortcode, start_time: '2018/07/10 13:00' } }
      before {get '/api/links/stats', params: params, xhr: true}

      it_behaves_like 'Success'

      it 'returns stats with 7 clicks' do
        expect(response.body).to eq "{\"clicks\":7}"
      end
    end

    context 'a end-time is only present' do
      let(:params) { { shortcode: link.shortcode, end_time: '2018/07/10 13:00' } }
      before {get '/api/links/stats', params: params, xhr: true}

      it_behaves_like 'Success'

      it 'returns stats with all clicks' do
        expect(response.body).to eq "{\"clicks\":10}"
      end
    end

    context 'a shortcode is not present' do
      let(:params) { { shortcode: nil } }
      before { get '/api/links/stats', params: params, xhr: true }

      it_behaves_like 'NotFound'

      it 'returns stats with all clicks' do
        expect(response.body).to be_empty
      end
    end

    context 'a shortcode is unknown' do
      let(:params) { { shortcode: 'unknown' } }
      before { get '/api/links/stats', params: params, xhr: true }

      it_behaves_like 'NotFound'

      it 'returns stats with all clicks' do
        expect(response.body).to be_empty
      end
    end
  end
end
