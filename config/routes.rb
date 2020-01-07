Rails.application.routes.draw do
  devise_for :users

  root 'products#index'
  
  resources :mypage, only: [:index, :show] do
    collection do
      get 'profile'
    end
  end

  resources :delivery_infos, only: [:new, :create]

  resources :products, only: [:new, :show, :index, :create] do
    get 'purchase_confirmation'
  end

  resources :signup, only: [:index, :create] do
    collection do
      get 'registration'
      get 'sms_confirmation'
      get 'sms_confirmation/sms', to: 'signup#sms_confirmation_sms'
      # signupのstep4住所入力はdelivery_infos_controllerで行う
      get 'credit_card'
      get 'done'
      post 'pay'
    end
  end

  resources :delivery_infos, only: [:new, :create]

  resources :mypage, only: [:index] do
    collection do
      get 'logout'
    end
  end

  resources :products, only: [ :index, :new, :create, :show] do
    member do
      # 商品購入の流れ
      get 'purchase_confirmation'
      post 'pay'
      get 'purchase_done'
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
