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
  
  resources :my_games, :my_word_lists, :my_posts do
    collection do
      get :search, :adopt
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
  end
  
  resources :comments

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
  
  match 'logout' => 'user_sessions#destroy', :as => :logout
  match 'trial' => 'schools#check', :as => :trial, :trial => 'true'
  match 'contact' => 'about#us', :as => :contact, :anchor => 'email'
  match '/' => 'about#index'
  match '/:controller(/:action(/:id))'
  root :controller => "about", :action => "index"
end

