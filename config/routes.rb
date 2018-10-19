Rails.application.routes.draw do
  resources :company_contacts
  resources :company_addresses
  root to: 'home#index'
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", unlocks: "users/unlocks", passwords: "users/passwords", confirmations: "users/confirmations" }, path_names: {sign_in: "login", sign_out: "logout"}
  as :user do
    get "/login" => "users/sessions#new"
    post "/login" => "users/sessions#create"
    delete "/logout" => "users/sessions#destroy"
  end

  resources :companies
end
