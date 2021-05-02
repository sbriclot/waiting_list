Rails.application.routes.draw do
  root to: 'requests#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :requests, only: [ :new, :create ]
  get 'confirmation', to: 'confirmations#confirmation'

  get 'saved', to: 'pages#saved'
  get 'validated', to: 'pages#validated'
  get 'too_late', to: 'pages#too_late'
end
