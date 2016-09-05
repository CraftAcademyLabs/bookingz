Rails.application.routes.draw do
  scope "(:locale)", locale: /en|se/ do
    devise_for :users
    post 'create_booking', controller: :dashboard, action: :create_booking
    root controller: :dashboard, action: :index
    get "/pages/*id" => 'pages#show', as: :page, format: false
  end
  
  namespace :api do
    get 'ping', controller: :api, action: :ping
  end

  get :api_index, controller: :dashboard, action: :api_index
end
