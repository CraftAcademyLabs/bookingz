Rails.application.routes.draw do

  scope '(:locale)', locale: /en|sv/ do
    devise_for :users
    post 'create_booking', controller: :dashboard, action: :create_booking
    post 'edit_booking', controller: :dashboard, action: :edit_booking
    delete 'delete_booking', controller: :dashboard, action: :delete_booking
    get '/pages/*id', controller: :pages, action: :show, as: :page, format: false
    get '/approvals/users', controller: :approvals, action: :index
    post '/approvals/users', controller: :approvals, action: :approve_user
    post :facility_user, controller: :facilities, action: :assign_user
    resources :facilities, only: [:index, :new, :create, :show]
    root controller: :dashboard, action: :index

    mount ActionCable.server => '/cable'
    get '/create_note', controller: :dashboard, action: :send_note, as: :note

  end

  namespace :api do
    get 'ping', controller: :api, action: :ping
    resources :resources, controller: :api, only: [:index, :create] do
      collection do
        get '/:uuid', action: :show, as: :show
        put '/', action: :update, as: :update
      end
    end
  end
end
