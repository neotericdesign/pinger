ActionController::Routing::Routes.draw do |map|
  map.resources :attempts, :only => :index
  map.resources :sites, :has_many => :attempts
  map.root :controller => 'sites'
end
