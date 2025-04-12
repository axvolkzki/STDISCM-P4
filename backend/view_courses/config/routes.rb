Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :courses, only: [:index]
       get "/courses", to: "courses#index"
    end
  end
end

