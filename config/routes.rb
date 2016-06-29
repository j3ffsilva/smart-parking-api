Rails.application.routes.draw do
  mount_devise_token_auth_for 'User',
    at: 'auth',
    controllers: {
      confirmations: 'overrides/confirmations',
      passwords:     'overrides/passwords'
    }

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

    # Incidents.
    post '/incidents'          => 'incidents#create'
    get  '/incidents/:spot_id' => 'incidents#index'

    # Checkins.
    post '/checkins'          => 'checkins#create'
    get  '/checkins/pending'  => 'checkins#pending'
    post '/checkins/checkout' => 'checkins#checkout'

    # We don't implement these routes yet, but we need to define them so that
    # the JSON API plugin will render associations correctly.
    get '/checkins/pending',   to: redirect('/'), as: :checkin
    get '/establishments',     to: redirect('/'), as: :establishments
    get '/establishments/:id', to: redirect('/'), as: :establishment
    get '/incidents/:id',      to: redirect('/'), as: :incident
    get '/spots',              to: redirect('/'), as: :spots
  end
end
