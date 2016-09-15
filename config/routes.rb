Rails.application.routes.draw do
  scope '(:locale)', locale: /en|sv/ do
    devise_for :users
    post 'create_booking', controller: :dashboard, action: :create_booking
    root controller: :dashboard, action: :index
    get '/pages/*id', controller: :pages, action: :show, as: :page, format: false
    get '/approvals/users', controller: :approvals, action: :show
  end

  namespace :api do
    get 'ping', controller: :api, action: :ping
    resources :resources, controller: :api, only: [:index, :create] do
      collection do
        get '/:uuid', action: :show, as: :show
      end
    end
  end

  get :api_index, controller: :dashboard, action: :api_index
end
