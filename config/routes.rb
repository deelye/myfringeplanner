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
  resources :performances, only: [:index] do
    resources :planners, only: [:create]
  end
  get '/planners', to: 'planners#index'
  delete '/planners/:id', to: 'planners#destroy', as: :delete_planner
end
