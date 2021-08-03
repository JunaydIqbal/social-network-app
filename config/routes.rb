Rails.application.routes.draw do
  
  root to: "home#index"
  
  get 'comments/create'
  resources :friendships
  get "remove_friend" => "friendships#destroy"

  resources :posts do
    member do
      put "like" => "posts#like"
      #post 'comments', to: 'comments#create'
    end
    resources :comments, module: :posts
  end

  resources :comments
  
  get "my_post", to: "posts#my_post"
  #devise_for :users
  devise_for :users, :controllers => {
    :registrations => "users/registrations",
    :sessions => "users/sessions",
    :passwords => "users/passwords",
    :confirmations => "users/confirmations"

  }

  devise_scope :users do 
    get 'signup', to: 'users/registrations#new'
    get 'signin', to: 'users/sessions#new'
    delete 'signout', to: 'users/sessions#destroy'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

end
