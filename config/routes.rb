Rails.application.routes.draw do
  root to: 'requests#new'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :requests, only: [ :new, :create ]

  get 'saved', to: 'pages#saved'
end
