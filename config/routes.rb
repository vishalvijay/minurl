Rails.application.routes.draw do
  api vendor_string: "min_url", default_version: 1 do
    version 1 do
      cache as: 'v1' do
        resources :min_urls, param: :token, only: [:create, :show, :update]
      end
    end
  end
  get '/:token', to: 'main#index'
  root to: 'main#index'
end
