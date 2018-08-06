# spec/integration/blogs_spec.rb
require 'swagger_helper'

describe 'Shorten API' do

  path 'api/links' do

    post 'shortens url' do
      tags 'Links'
      consumes 'application/json', 'application/xml'
      parameter name: :link, in: :body, schema: {
          type: :object,
          properties: {
              url: { type: :string }
          },
          required: [ 'url' ]
      }

      response '201', 'link is created' do
        let(:link) { { url: 'https://github.com/' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:link) { { url: '' } }
        run_test!
      end
    end
  end
end