Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # # Defines the root path route ("/")
  root "send_messages#new"
  resources :send_messages

  post '/send_messages/create', to: 'send_messages#create', as: 'create_messages'

  post '/delivery_status', to: 'send_messages#delivery_status', as: 'update_status'
  namespace :dev do
    # API endpoint for posting to provider 1
    post "provider1", to: "send_messages#provider_one"

    # API endpoint for posting to check for delivery status
    post 'delivery_status', to: 'send_messages#delivery_status'
    
    # Defines the root path route ("/")
    root to: "send_messages#index"
    resources :send_messages
  end
end
