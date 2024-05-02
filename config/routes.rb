Rails.application.routes.draw do
  get "wallets/index"
  get "wallets/show"
  get "wallets/edit"
  get "wallets/new"
  devise_for :users

  concern :localizable do
    put :change_locale, controller: "application"
  end

  scope :admin, module: :admin, as: :admin do
    concerns :localizable
    draw :admin
  end

  scope "/", module: :web, as: :web do
    concerns :localizable
    draw :web
  end
end
