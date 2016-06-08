Rails.application.routes.draw do
  # For details on the DSL available within this file, see:
  # http://guides.rubyonrails.org/routing.html.

  # For a discussion on the different trade-offs between API versioning methods
  # see: https://gitlab.com/smart-city-platform/smart_parking_api/wikis/useful-links

  root 'application#index'

  v1_params = {
    module: 'V1',
    default: true,
    defaults: {
      format: :json
    },
    header: {
      name: 'Accept',
      value: 'application/vnd.smartcityplatform; version=1'
    },
    path: { value: 'v1' }
  }

  api_version(v1_params) do
    get '/spots/search' => 'spots#search'
    get '/spots/:id'    => 'spots#show', as: :spot
  end
end
