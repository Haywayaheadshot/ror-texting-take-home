Rails.application.routes.draw do
  resources :invalid_numbers
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # # Defines the root path route ("/")
  root "send_messages#new"
  resources :send_messages

  post '/send_messages/create', to: 'send_messages#create', as: 'create_messages'

  post '/delivery_status', to: 'send_messages#delivery_status', as: 'update_status'
  namespace :dev do
    # API endpoint for posting to provider 1
    post "provider1", to: "send_messages#provider_one"

    # API endpoint for posting to update for attempt_status
    post 'delivery_status', to: 'send_messages#delivery_status'

    # API endpoint for posting to check attempt_status
    post 'check_attempt_status', to: 'send_messages#find_message_status'

    # API endpoint to find message in db
    post 'find_message', to: 'send_messages#find_message'
    
    # Defines the root path route ("/")
    root to: "send_messages#index"
    resources :send_messages
  end
end
