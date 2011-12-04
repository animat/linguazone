Linguazone::Application.routes.draw do
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
  match 'about/pricing' => 'about#pricing', :as => :pricing
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'trial' => 'schools#check', :as => :trial, :trial => 'true'
  match 'contact' => 'about#us', :as => :contact, :anchor => 'email'
  match '/' => 'about#index'
  match '/:controller(/:action(/:id))'
  root :controller => "about", :action => "index"
end

