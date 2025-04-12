Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'enroll', to: 'enroll_courses#enroll'
    end
  end
end
