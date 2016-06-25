Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
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

    # We don't implement these routes yet, but we need to define them so that
    # the JSON API plugin will render associations correctly.
    get '/establishments', to: redirect('/'), as: :establishments
    get '/establishments/:id', to: redirect('/'), as: :establishment

    get  '/incidents/last' => 'incidents#last'
    get  '/incidents/:id' => 'incidents#show', as: :incident

    get '/users', to: redirect('/'), as: :users
    get '/users/:id', to: redirect('/'), as: :user

    post '/incidents' => 'incidents#create'
  end
end
