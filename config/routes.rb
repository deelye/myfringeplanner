Rails.application.routes.draw do
  devise_for :users
  get 'planner', to: 'pages#planner'

  root to: 'pages#home'
  get 'shortlist', to: 'pages#shortlist'
  resources :shows, only: [:show, :index] do
    member do
      get 'follow'
      get 'unfollow'
    end
  end

  resources :shortlist, only: [:show]

  # should remove planner resources as going through pages now?
  resources :planner, only: [:show, :edit, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
