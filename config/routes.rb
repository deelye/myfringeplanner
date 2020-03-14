Rails.application.routes.draw do
  devise_for :users

  root to: 'pages#home'

  resources :shows, only: [:show, :index] do
    member do
      get 'follow'
      get 'unfollow'
    end
  end

  resources :performances, only: [:index] do
    resources :planners, only: [:create]
  end

  get 'shortlist', to: 'pages#shortlist'
  resources :shortlist, only: [:show]

  get 'planner', to: 'pages#planner'

  get 'planners', to: 'planners#index'
  delete 'planners/:id', to: 'planners#destroy', as: :delete_planner

  get 'contact', to: 'pages#contact'
  get 'about', to: 'pages#about'
end
