Rails.application.routes.draw do
  post '/login', to: 'sessions#login'
  delete '/logout', to: 'sessions#logout'

  resources :products, only: %i[index show create update destroy]
  resources :categories, only: %i[index show create update destroy]
end
