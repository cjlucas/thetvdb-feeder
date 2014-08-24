Rails.application.routes.draw do
  root 'application#index'

  get 'users/:tvdb_id/new' => 'users#new'
  get 'users/:uid/logout' => 'users#logout', as: :logout
  get 'users/:tvdb_id' => 'users#get'
  post 'users/settings' => 'users#update_settings'

  get 'feeds/ical' => 'feed#ical', as: :ical
end
