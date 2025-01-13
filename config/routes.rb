Rails.application.routes.draw do
  devise_for :users
  resources :products, only: %i[index show create update destroy]
  resources :categories, only: %i[index show create update destroy]
end
