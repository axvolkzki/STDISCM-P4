Rails.application.routes.draw do
  get "/", to: "grades#index"
  post "/", to: "grades#upload"
end
