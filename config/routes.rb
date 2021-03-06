Rails.application.routes.draw do

  devise_for :users , controllers: { confirmations: 'confirmations' }
  resources :relationships
  resources :user_steps
  resources :users do
    member do
      get :following, :followers
      end 
    end
  resources :notifications do
    collection do
      post :mark_as_read
    end
  end
    resources :users do
    member do
      get "connects" => "users#connects"
      get "networks" => "users#networks"
      end 
    end
    resources :interestgroups do
      member do
        put "like", to: "interestgroups#upvote"
      end
    end
    get '/interestgroups' => 'interestgroups#index'
mount Commontator::Engine => '/commontator'
   resources :updates do
    member do
      put "like" => "updates#upvote"
      put "unlike" => "updates#downvote"
    end
  end
  resources :conversations do
    resources :memos
  end
   resources :messages do
      resources :comments
    end
   get '/messages' => 'messages#index'
   get '/community' => 'community#index'
   get 'community/index' => 'community#index'
   get '/groups' => 'pages#groups'
   get '/surf' => 'pages#explore'

 # get 'community/browse'

  #get 'community/search'

  root "pages#index"
  match '/users', to: 'users#index', via: 'get'
  get '/home/hashtags/',         to: 'hashtags#index',     as: :hashtags
get '/hashtags/:hashtag', to: 'hashtags#show',      as: :hashtag

  get '/home' => 'pages#home'
  #get '/users/connects' => 'users#connects'

  get '/user/:id' => 'pages#hub'

  get '/explore' => 'pages#explore'
  #get 'control/index'
  #get '/assets/fonts/muli.woff2' => 'assets/fonts'

  #get "demo/index"
  match ':controller(/:action(/:id))', :via => :get

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
