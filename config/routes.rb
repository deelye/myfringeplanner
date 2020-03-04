Rails.application.routes.draw do
  get 'planners/show'
  get 'planners/edit'
  get 'planners/create'
  devise_for :users

  root to: 'pages#home'
  resources :shows, only: [:show, :index] do
    member do
      get 'follow'
      get 'unfollow'
    end
  end

  resources :shortlist, only: [:show]

  resources :planner, only: [:show, :edit, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
