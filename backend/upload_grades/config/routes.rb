Rails.application.routes.draw do
  root "grades#index"
  post "/", to: "grades#upload"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
