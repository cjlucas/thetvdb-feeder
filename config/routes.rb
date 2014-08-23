Rails.application.routes.draw do
  get 'feeds/ical' => 'feed#ical'
end
