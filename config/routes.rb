Rails.application.routes.draw do
  mount Rswag::Api::Engine => '/api-docs'
  mount Rswag::Ui::Engine => '/api-docs'
  api vendor_string: 'shorten', default_version: 1 do
    version 1 do
      cache as: 'v1' do
        resources :links, only: :create do
          get :redirect, on: :collection
          get :stats, on: :collection
        end

      end
    end
  end
end
