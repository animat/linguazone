Linguazone::Application.routes.draw do
  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :teachers do
    collection do
      get :getting_started
      get :login
    end
  end

  resources :students do
    collection do
      get :select_school
      get :register
      get :login
    end
  end

  resources :schools do
    collection do
      get :autocomplete_name
      get :check
      get :confirm
      get :confirm_or_new
    end
  end

  resources :posts do
    collection do
      get :upgrade_reminder
    end
  end

  resources :states
  resources :play
  resources :users
  resources :user_sessions
  resources :high_scores
  resources :comments
  resources :media
  resources :password_resets
  resources :my_posts, :my_games, :my_courses, :my_word_lists
  match 'customize/:action/:cmzr_type/:id' => 'customize#index', :cmzr_type => nil, :id => nil
  match 'class/:id' => 'courses#show'
  match 'class/:id/feed' => 'courses#feed'
  
  #TODO: Is there any way to simplify these statements?
  match 'about/pricing' => 'about#pricing', :as => :pricing
  match 'about/features' => 'about#features'
  match 'about/games' => 'about#games'
  match 'about/audio_blogs' => 'about#audio_blogs'
  match 'about/word_lists' => 'about#word_lists'
  match 'about/us' => 'about#us'
  match 'about/languages' => 'about#languages'
  
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'trial' => 'schools#check', :as => :trial, :trial => 'true'
  match 'contact' => 'about#us', :as => :contact, :anchor => 'email'
  match '/' => 'about#index'
  match '/:controller(/:action(/:id))'
  root :controller => "about", :action => "index"
end

