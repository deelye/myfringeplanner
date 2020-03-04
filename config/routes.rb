Rails.application.routes.draw do
  get 'shortlists/show'
  devise_for :users

  root to: 'pages#home'
  resources :shows, only: [:show, :index] do
    member do
      get 'follow'
      get 'unfollow'
    end
  end

  resources :shortlist, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
