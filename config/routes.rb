Rails.application.routes.draw do

  devise_for :users
  post 'create_booking', controller: :dashboard, action: :create_booking
  root controller: :dashboard, action: :index
  get "/pages/*id" => 'pages#show', as: :page, format: false

  namespace :api do
    get 'ping', controller: :api, action: :ping
    resources :resources, controller: :api, only: [:index] do
      collection do
        get '/:uuid', action: :show, as: :show
      end
    end
  end

  get :api_index, controller: :dashboard, action: :api_index
end
