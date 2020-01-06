Rails.application.routes.draw do
  
  root 'products#index'
  resources :products, only: [:show, :index] do
  end

  resources :mypage, only: [:index, :show] do
  end

  resources :products, only: [:new, :show, :index] do
    get 'purchase_confirmation', to:'products#purchase_confirmation'
  end

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
