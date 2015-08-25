Rails.application.routes.draw do

  get 'sessions/new'
  get 'comments/new'
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy', :as => "logout"
  root 'static_pages#home'
  get "changestatus" => "users#changestatus"
  get "is_goods" => "microposts#is_goods"
  get "is_reports" => "microposts#is_reports"
  get "report_viewed" => "users#report_viewed"
  get "report_deleted" => "users#report_deleted"
  get "report_destroy" => "users#report_destroy"
  get "forwarding_micropost" => "microposts#forwarding_micropost"
  get "search_name_users" => "users#search_name_users"

  resources :users do
    member do
      get :following, :followers,:reportinformation
    end
  end
  resources :microposts, only: [:create, :destroy]

  resources :comments, only: [:create, :destroy]

  resources :relationships, only: [:create, :destroy]

  resources :account_activations, only: [:edit]
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"


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
