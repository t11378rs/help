Rails.application.routes.draw do
  root  'static_pages#home'

  #get "static_pages/home"
  #get "static_pages/help"
  #get "static_pages/about"
  
  resources :users #ユーザーのURLを生成するための多数の名前付きルート (5.3.3) に従って、RESTfulなUsersリソースで必要となるすべてのアクションが利用できるようになります
  match '/signup',  to: 'users#new',  via: 'get' 
  
  resources :sessions, only: [:new, :create, :destroy] #新しいセッションを作成する
  match '/signin',  to: 'sessions#new',  via: 'get' #新しいセッション用(サインイン)
  match '/signuot',  to: 'sessions#destroy',  via: 'delete' #セッションの削除(サインアウト)

  resources :helpposts, only: [:create, :destroy, :show] do #postのルーティング
    member do
      resources :comments, only: [:create]
    end
  end

  #resources :comments, only: [:create]

  resources :static_pages, only: [:get]
  match '/home', to: 'static_pages#home', via: 'get'
  match '/help', to: 'static_pages#help', via: 'get'
  match '/about', to: 'static_pages#about', via: 'get'
  #get 'static_pages/home'
  #get 'static_pages/help'

  #get 'users/new'
  #match '', to: 'users#new', via: 'get' #http://localhost:4000/でデフォルトページ

  #RESTスタイルのURLを有効にする
  #resource :users


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
