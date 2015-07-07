Linguazone::Application.routes.draw do
  get "feed_items_controller/index"

  resources :authentications

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
      get :confirm_course_enter_code
      get :register
      get :find_class
      get :login
    end
    resources :feed_items, :only => [:index]
  end
  
  resources :authentications, :only => [:index, :create, :destroy] do
    collection do 
      post :cancel
    end
  end
  match '/auth/:provider/callback' => 'authentications#create'

  resources :schools do
    collection do
      get :autocomplete_name
      get :search
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
  
  resources :my_games, :my_posts do
    collection do
      get :search, :adopt
    end
  end
  
  resources :my_word_lists do
    collection do
      get :search, :adopt, :import, :confirm_spreadsheet_import, :create_by_spreadsheet
    end
  end
  #TODO @Len: Is there an efficient way to create a new path here and establish parameters?
  #match 'my_games/search/hidden_games_on_class/:course_id' => 'my_games#search', params[:search][:hidden_equals] => 1, params[:search][:course_id] => nil
  #match 'my_word_lists/search/hidden_word_lists_on_class/:course_id' => 'my_word_lists#search', :search[:hidden_equals] => 1, :search[:course_id] => nil
  #match 'my_posts/search/hidden_posts_on_class/:course_id' => 'my_posts#search', :search[:hidden_equals] => 1, :search[:course_id] => nil
  #
  namespace :api do
    namespace :v1 do
      resources :media_categories, :courses, :only => [:index]
      resources :games do
        collection do
          get :info
        end
      end
      resources :audio_clips, :high_scores, :word_lists
      resources :medias, :available_games, :available_word_lists, :games_word_lists, :only => [:index] do
        collection do
          get :search
        end
      end
    end
    namespace :v2 do
      resources :courses, :games, :posts, :word_lists, :students, only: :show
      resources :available_games, :available_word_lists, :available_posts, only: [:index, :show]
      resources :feed_items, only: :student
      match "auth/sign_in" => "user_sessions#create", :via => :post
      match "auth/sign_out" => "user_sessions#destroy", :via => :delete
    end
  end

  resources :courses do
    collection do
      get :order_games
      get :add_game, :add_list, :add_post
      get :search_hidden_games, :search_hidden_word_lists, :search_hidden_posts
      match "hide_game/:available_game_id" => "courses#hide_game", :via => :post, :as => "hide_game"
      match "hide_word_list/:available_word_list_id" => "courses#hide_word_list", :via => :post, :as => "hide_word_list"
      match "hide_post/:available_post_id" => "courses#hide_post", :via => :post, :as => "hide_post"
      match "show_game/:available_game_id" => "courses#show_game", :via => :post, :as => "show_game"
      match "show_word_list/:available_word_list_id" => "courses#show_word_list", :via => :post, :as => "show_word_list"
      match "show_post/:available_post_id" => "courses#show_post", :via => :post, :as => "show_post"
    end
    
    post :send_invites
    
    resources :course_registrations
    resources :feed_items do
      collection do
        get :index
        get :gradebook
      end
    end
  end
  
  resources :course_registrations do
    resources :feed_items, :only => [:index]
  end
  
  resources :comments do
    collection do
      put :set_rating
    end
  end

  resources :my_courses
  resources :play, :high_scores
  resources :users, :user_sessions
  resources :states, :media, :password_resets
  match 'customize/:action/:cmzr_type/:id' => 'customize#index', :cmzr_type => nil, :id => nil
  match 'class/:id' => 'courses#show'
  match 'class/:id/feed' => 'courses#feed'
  match 'courses/:id/feed' => 'courses#feed'
    
  # TODO: Is there any way to simplify these statements?
  match 'about/pricing' => 'about#pricing', :as => :pricing
  match 'about/features' => 'about#features'
  match 'about/games' => 'about#games'
  match 'about/audio_blogs' => 'about#audio_blogs'
  match 'about/word_lists' => 'about#word_lists'
  match 'about/us' => 'about#us'
  match 'about/languages' => 'about#languages'
  match 'about/help' => 'about#help'
  
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'trial' => 'schools#check', :as => :trial, :trial => 'true'
  match 'contact' => 'about#us', :as => :contact, :anchor => 'email'
  match '/' => 'about#index'
  match '/:controller(/:action(/:id))'
  root :controller => "about", :action => "index"
end

