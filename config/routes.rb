Rails.application.routes.draw do
  resources :products, only: %i[index show create update destroy]
  resources :categories, only: %i[index show create update destroy]

  post '/login', to: 'sessions#login'
  delete '/logout', to: 'sessions#logout'
end
