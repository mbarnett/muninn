ActionController::Routing::Routes.draw do |map|
  map.resource :account, :controller => "users"
  
  map.resources :users
  map.resource :user_session 
  map.resources :tweets, :except => [:edit, :update, :destroy] # No meaningful way to provide these for tweets
  
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.register "register", :controller => "users", :action => "new"
  
  map.root :controller => "tweets", :action => "index"
end
