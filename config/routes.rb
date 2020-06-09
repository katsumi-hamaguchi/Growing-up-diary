Rails.application.routes.draw do
  resources :events
  devise_for :users
  resources :users
  root 'homes#top'
  get 'users/event/:id' => 'users#event',as:"event_user"
  get 'users/withdrawal/:id' => 'users#withdrawal',as:"withdrawal" 
  put 'users/retire/:id' => 'users#update_user', as: "retire"
  get 'users/change_pass/:id' => 'users#change_pass',as:"change_pass" 
  put 'pass/change/:id' => 'users#update_pass', as: "change"

  resources :diaries do
    resource :favorites, only: [:create, :destroy]
  end
  get 'diaries/index_all/:id' => 'diaries#index_all',as:"index_all"
  resources :tasks

  get 'search' => 'searches#search',as:'search'
  get 'search_all' => 'searches#search_all',as:'search_all'
end
