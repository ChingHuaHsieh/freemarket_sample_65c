Rails.application.routes.draw do
  
  devise_for :users
  root 'products#index'

  resources :delivery_infos, only: [:new, :create]

  resources :products, only: [:new, :show, :index, :create] do
    get 'purchase_confirmation'
  end

  resources :signup, only: [:index, :create] do
    collection do
      get 'registration'
      get 'sms_confirmation'
      get 'sms_confirmation/sms', to: 'signup#sms_confirmation_sms'
      get 'address'
      get 'credit_card'
      get 'done'
      post 'pay'
    end
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
