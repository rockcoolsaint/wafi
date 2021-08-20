Rails.application.routes.draw do
  resources :accounts
  # get 'transactions/withdraw'
  # get 'transactions/deposit'
  # get 'transactions/transfer'
  get 'pages/home'
  resources :users do
    resources :accounts do
      member do
        get :withdraw, to: "accounts#new_withdraw"
        get :deposit, to: "accounts#new_deposit"

        post :withdraw, to: "accounts#withdraw"
        post :deposit, to: "accounts#deposit"

        get :transfer_page, to: "transactions#transfer_page"
        post :transfer, to: "transactions#transfer"
      end
    end
  end
  # resources :accounts
  resources :users
  root 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
