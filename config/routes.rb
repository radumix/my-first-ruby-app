Rails.application.routes.draw do
  resources :contacts
  get "new", to: "contacts#new"
  get "index", to: "contacts#index"
  root "contacts#home"
end
