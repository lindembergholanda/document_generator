Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", unlocks: "users/unlocks", passwords: "users/passwords", confirmations: "users/confirmations" }, path_names: {sign_in: "login", sign_out: "logout"}
  as :user do
    get "/login" => "users/sessions#new"
    post "/login" => "users/sessions#create"
    delete "/logout" => "users/sessions#destroy"
  end

  resources :companies
  resources :company_addresses
  resources :company_contacts
  resources :document_types
  resources :subjects
  resources :documents do
    put :complete
    get :show_document
    collection do
      post :load_contacts
    end
  end

end
