Rails.application.routes.draw do
  api vendor_string: 'shorten', default_version: 1 do
    version 1 do
      cache as: 'v1' do
      end
    end
  end
end
