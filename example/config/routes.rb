Rails.application.routes.draw do
  get "/students", to: "students#index"
  post "/students", to: "students#create"
  get "/students/:id", to: "students#show"
  delete "/students/:id", to: "students#destroy"
  patch "/students/:id", to: "students#update"
end
