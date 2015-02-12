Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resource :search, only: [:new, :create], controller: :search
end
