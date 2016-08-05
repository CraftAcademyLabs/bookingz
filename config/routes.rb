Rails.application.routes.draw do

  devise_for :users
  root controller: :dashboard, action: :index

end
