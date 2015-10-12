Rails.application.routes.draw do
  # NOTE: Root to the static page and have React.js take over
  root to: 'static_pages#root'

  # NOTE: Defaulting to json and use api namespace
  namespace :api, defaults: {format: :json} do
    resources :benches, only: [:index, :create]
  end
end
