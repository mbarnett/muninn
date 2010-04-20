ActionController::Routing::Routes.draw do |map|
  map.resource :account, :controller => "users", :only => [:new, :create, :edit, :update]
  
  map.resources :users, :only => [:new, :create, :edit, :update] do |users|
    users.resources :historic_tweets, :only => [:create, :index]
    users.resource :authorizations, :only => [:new, :create, :destroy]
    users.resource :timelines, :only => [:index]
  end
  
  map.resource :user_session, :only => [:new, :create, :destroy]
  
  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.register "register", :controller => "users", :action => "new"
  
  map.root :controller => "timelines", :action => "index"
end
