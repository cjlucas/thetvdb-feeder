Rails.application.routes.draw do
  root 'application#index'

  get 'users/refresh' => 'users#refresh', as: :refresh
  get 'users/new' => 'users#new'
  get 'users/:uid/logout' => 'users#logout', as: :logout
  post 'users/login' => 'users#login', as: :login
  post 'users/settings' => 'users#update_settings'

  get 'feeds/ical' => 'feed#ical', as: :ical
end
