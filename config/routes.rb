Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations", unlocks: "users/unlocks", passwords: "users/passwords", confirmations: "users/confirmations" }, path_names: {sign_in: "login", sign_out: "logout"}
  
  post 'set_locale' => 'application#set_locale'
  
  as :user do
    get "/login" => "users/sessions#new"
    post "/login" => "users/sessions#create"
    delete "/logout" => "users/sessions#destroy"
  end

  namespace :states do
      post :load_cities
  end
  
  resources :companies
  resources :company_addresses
  resources :company_contacts
  resources :document_types
  resources :subjects
  resources :documents do
    post :finish
    get :show_document
    collection do
      post :load_contacts
    end
  end

  get 'documents/validation/:autentication' => 'api/v1/documents#validation', as: :document_validation

end
