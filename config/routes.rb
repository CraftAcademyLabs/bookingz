Rails.application.routes.draw do

  devise_for :users
  post 'create_booking', controller: :dashboard, action: :create_booking
  root controller: :dashboard, action: :index

end
