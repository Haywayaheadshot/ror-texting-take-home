Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  namespace :dev do
    resources :send_messages

    # API endpoint for posting to provider 1
    post "dev/provider1", to: "dev/send_messages#provider_one"
  end
end
