ActionController::Routing::Routes.draw do |map|
  
  map.resources :teachers, :collection => { :login => :get, :getting_started => :get}
  map.resources :students, :collection => { :login => :get, :register => :get, :select_school => :get }
  map.resources :schools, :collection => { :check => :get, :confirm => :get, :confirm_or_new => :get}
  map.resources :posts, :collection => {:upgrade_reminder => :get}
  
  map.resources :states, :play, :users, :user_sessions, :high_scores, :comments, :media, :password_resets
  
  map.connect 'customize/:action/:cmzr_type/:id', :controller => "customize", :cmzr_type => nil, :id => nil
  map.connect 'class/:id', :controller => "courses", :action => "show"
  map.connect 'class/:id/feed', :controller => "courses", :action => "feed"
  
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.trial "trial", :controller => "schools", :action => "check", :trial => "true"
  map.contact "contact", :controller => "about", :action => "us", :anchor => "email"
  
  map.root :controller => "about", :action => "index"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
  
end
