Rails.application.routes.draw do
  root 'products#index'
  resources :products, only: [:new, :show, :index]

  namespace :api do
    resources "products", controller: :products, only: :child, defaults: { format: 'json' } do
      collection do
        get 'child'
      end
    end
    resources "products", controller: :products, only: :grand_child, defaults: { format: 'json' } do
      collection do
        get 'grand_child'
      end
    end
  end
end
