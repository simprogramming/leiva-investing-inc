controller :admin do
  get "/", action: :admin, as: :admin
end

resources :users
resources :stocks do
  collection do
    get :update_prices
  end
end
root "admin#admin"
