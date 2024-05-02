controller :admin do
  get "/", action: :admin, as: :admin
end

resources :stocks do
  collection do
    get :update_prices
  end
end

resources :positions
resources :users
resources :wallets
root "admin#admin"
