Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'login', to: 'authentication#login'
      post 'validate', to: 'authentication#validate' # Should be POST
    end
  end
end