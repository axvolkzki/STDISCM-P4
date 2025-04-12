Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
        get "view", to: "enroll#view" 
        post "enroll", to: "enroll#index"   
    end
  end
end
