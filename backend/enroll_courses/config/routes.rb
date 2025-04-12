Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "/enroll", to: "enroll#enroll"
      get '/list', to: 'enroll#list'
    end
  end
end
