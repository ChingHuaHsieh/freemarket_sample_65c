Rails.application.routes.draw do
  root 'products#index'
  resources :products, only: [:show, :index] do
  end

  resources :mypage, only: [:index, :show] do
  end
end
