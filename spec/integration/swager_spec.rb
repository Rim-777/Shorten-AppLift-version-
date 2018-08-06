# require 'swagger_helper'
#
# describe 'Shorten API' do
#   path 'api/links' do
#     post 'shortens url' do
#       tags 'Create'
#       consumes 'application/json'
#       parameter name: :url, in: :body, schema: {
#           type: :object,
#           properties: {
#               url: {type: :string}
#           },
#           required: ['url']
#       }
#
#       response '201', 'created' do
#         examples 'application/json' => {
#             url: 'https://github.com/rim-777/timomoss',
#             shortcode: 'QW2ERt'
#         }
#
#         let(:link) { { url: 'https://github.com/' } }
#         run_test!
#       end
#
#       response '422', 'Invalid params' do
#         examples 'application/json' => {
#             url: ["can't be blank"]
#         }
#
#         let(:link) {{url: ''}}
#         run_test!
#       end
#     end
#   end
#
#   path 'api/links/redirect' do
#     get 'redirects to the real url' do
#       tags 'Redirect'
#       consumes 'application/json'
#       parameter name: :shortcode, in: :path, schema: {
#           type: :object,
#           properties: {
#               shortcode: {type: :string}
#           },
#           required: ['shortcode']
#       }
#
#       response '200', 'redirects to the url' do
#         let(:shortcode) {Link.create(url: 'https://github.com/').shortcode}
#         run_test!
#       end
#
#       response '404', "Not found" do
#         let(:shortcode) {''}
#         run_test!
#       end
#     end
#   end
#
#   path 'api/links/stats' do
#     get 'returns stats for the specific period or total clicks number' do
#       tags 'Stats'
#       consumes 'application/json'
#       parameter name: :shortcode, in: :path, schema: {
#           type: :object,
#           properties: {
#               shortcode: {type: :string}
#           },
#           required: ['shortcode'],
#       }
#
#       parameter name: :start_time, in: :path, schema: {
#           type: :object
#       }
#
#       parameter name: :end_time, in: :path, schema: {
#           type: :object
#       }
#       response '200', 'returns  a clicks number' do
#         examples 'application/json' => {
#             clicks: 150
#         }
#
#         let(:clicks) {Link.create(url: 'https://github.com/').stats(nil, nil)}
#         run_test!
#       end
#
#       response '404', "Not found" do
#         let(:shortcode) {''}
#         run_test!
#       end
#     end
#   end
# end
