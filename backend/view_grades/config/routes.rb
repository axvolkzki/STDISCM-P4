Rails.application.routes.draw do
  get "/", to: "grades#index"
end
