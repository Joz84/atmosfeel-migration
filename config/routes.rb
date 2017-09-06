Rails.application.routes.draw do
  authenticate :admin do
    require 'sidekiq/web'
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users
  devise_for :admins, controllers: { sessions: "back/sessions" }

  devise_scope :user do
    match '/users/sign_out' => 'devise/sessions#destroy', via: [:get, :delete]
  end

  namespace :back do
    root 'opuses#index'
    resources :opuses, except: [:new, :create, :show] do
      get 'read', on: :member
      get 'duplicate', on: :member
      patch 'create_copy', on: :member
    end
    resources :users, only: [:index, :show] do
      collection do
        get 'sells'
        post 'sells_report'
        get 'views'
        post 'views_report'
        get 'newsletter'
      end
    end
    resources :collaboration_types, :atmospheres, :play_times, :keywords, :languages, except: [:show]
    resources :plans, :discount_codes, except: [:show]
  end

  namespace :front, path: '' do
    root 'pages#home'

    get 'qui-sommes-nous'      => 'pages#about', as: 'about'
    get 'abonnement'           => 'pages#tarifs', as: 'tarifs'
    get 'nous-parlons-de-vous' => 'pages#nous_parlons_de_vous', as: 'nous_parlons_de_vous'
    get 'mentions-legales'     => 'pages#mentions_legales', as: 'mentions_legales'
    get 'cgv'                  => 'pages#cgv'
    get 'espace-abonne'        => 'pages#index', as: 'espace_abonne'
    get 'comment-ca-marche'    => 'pages#ccm', as: 'ccm'

    localized do
      resources :opuses, except: [:index] do
        get 'read', on: :member
        get 'toggle_publish', on: :member
        resources :comments, only: [:create]
      end
    end

    get 'bibliofeel'         => 'bibliofeel#index'
    post 'bibliofeel/filter' => 'bibliofeel#filter'
    get 'bibliofeel/:id/remove' => 'bibliofeel#remove', as: 'bibliofeel_remove_entry'
    get 'bibliofeel/:id/leave' => 'bibliofeel#leave', as: 'bibliofeel_leave_opus'

    get 'profile'                => 'settings#profile'
    post 'update_profile'        => 'settings#update_profile'
    get 'toggle_artist'          => 'settings#toggle_artist'
    get 'toggle_accepts_contact' => 'settings#toggle_accepts_contact'
    get 'bank'                   => 'settings#bank'

    localized do
      get "experience"  => "experience#index"
      get 'marketplace' => "marketplace#index"
    end

    %w{experience marketplace}.each do |path|
      localized do
        get "#{path}/:id"     => "#{path}#show", as: "#{path}_product"
      end
      post "#{path}/filter" => "#{path}#filter"
    end
    get "catalog/:id/flag"  => "catalog#flag", as: "catalog_flag"
    get "feellists/:id/add" => "feellists#add", as: 'feellists_add'

    localized do
      get 'catalog/:id/preview' => 'preview#show', as: 'preview_product'

      resources :authors, only: [:index, :show] do
        post 'order', on: :collection
        post 'contact', on: :member
      end
    end

    resources :users, only: [:update]

    get 'paypal-return'                       => 'agreements#paypal_return'
    get 'paypal-cancel'                       => 'agreements#paypal_cancel'
    post 'paypal-ipn'                         => 'agreements#paypal_ipn'
    post 'update_bank'                        => 'settings#update_bank'
    get 'subscription'                        => 'agreements#subscription'
    get 'plans/:discount_code_value/discount' => 'plans#discount', as: 'plans_discount'
    get 'plans/:fixed_id'                     => 'plans#select', as: 'plans_select'

    post 'payplug-ipn'    => 'orders#payplug_ipn'
    get 'payment/confirm' => 'orders#confirm'
    get 'payment/cancel'  => 'orders#cancel'

    get 'cart/:id/add'     => 'carts#add', as: 'carts_add'
    get 'cart/:id/remove'  => 'carts#remove', as: 'carts_remove'
    get 'cart/resume'      => 'carts#resume', as: 'carts_resume'
    get 'cart/:id/confirm' => 'carts#confirm', as: 'carts_confirm'

    get 'likes' => 'likes#index', as: 'likes'
    post "likes/filter" => "likes#filter", as: 'likes_filter'
    post 'likes/:id' => 'likes#create', as: 'like'

    get 'history' => 'orders#history', as: 'history'
  end


  namespace :api do
    post 'users/filter'    => 'users#filter'
    resources :keywords, only: [:index, :create] do
      post 'filter', on: :collection
    end
    resources :files, only: [:create]

    namespace :v1, defaults: { format: :json } do
      devise_for :users, skip: [:passwords, :registrations]
      resources :play_times, only: [:index]
      resources :languages, only: [:index]
      resources :atmospheres, only: [:index]
      resources :authors, only: [:index, :show]
      resources :bibliofeel, only: [:index]
      resources :opuses, only: [:index, :show] do
        member do
          resources :authors, only: [:index]
          resources :comments, only: [:index, :create]
          resources :likes, only: [:create]
        end
      end
      get '/opuses/:id/read' => "opuses#read", as: 'opus_read'
      post '/opuses/:id/logs' => "opuses#logs", as: 'opus_log'
      patch '/opuses/:id/toggle_readed' => "opuses#toggle_readed", as: 'toggle_readed'
    end
  end
end
