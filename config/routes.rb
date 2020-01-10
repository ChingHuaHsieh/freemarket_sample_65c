Rails.application.routes.draw do
  devise_for :users

  root 'products#index'

  resources :signup, only: [:index, :create] do
    collection do
      get 'registration'
      get 'sms_confirmation'
      get 'sms_confirmation/sms', to: 'signup#sms_confirmation_sms'
      # signupのstep4住所入力はdelivery_infos_controllerで行う
      get 'credit_card'
      post 'pay'
      get 'done'
    end
  end

  resources :delivery_infos, only: [:new, :create]

  resources :mypage, only: [:index] do
    collection do
      get 'identification'
      get 'logout'
      get 'profile'
    end
  end

  resources :products do
    resources :comments, only: [:create, :update]
    member do
      # 商品購入の流れ
      get 'purchase_confirmation'
      post 'pay'
      get 'purchase_done'
    end
  end

  # 出品時に使用
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
