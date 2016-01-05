Rails.application.routes.draw do
  resources :schools do
    collection do
      get :autocomplete_name
      get :search
      get :check
      get :confirm
      get :confirm_or_new
    end
  end
  root 'home#index'
end
