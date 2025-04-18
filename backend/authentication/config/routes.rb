Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'login', to: 'authentication#login'
      post 'validate', to: 'authentication#validate'
      post 'logout', to: 'authentication#logout'

      get 'dashboard/student', to: 'dashboard#student'
      get 'dashboard/professor', to: 'dashboard#professor'
    end
  end
end