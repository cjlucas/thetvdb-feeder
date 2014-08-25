Rails.application.routes.draw do
  root 'application#index'

  get 'users/refresh' => 'users#refresh', as: :refresh
  get 'users/new' => 'users#new'

  get 'login' => 'sessions#index', as: :login
  post 'login' => 'sessions#login'
  delete 'login' => 'sessions#logout'
  get 'logout' => 'sessions#logout', as: :logout

  post 'users/settings' => 'users#update_settings'

  get 'dashboard' => 'dashboard#index', as: :dashboard

  get 'feeds/ical' => 'feed#ical', as: :ical
end
