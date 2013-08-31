JobsRubynow::Application.routes.draw do
   resources :jobposts
   resources :users
   resources :sessions, only: [:new, :create, :destroy]

  #current_cart 'cart', :controller => 'carts', :action => 'show', :id => 'current'
  resources :line_items
  resources :carts
  resources :products
  resources :categories
  resources :payments #, :collection => { :credit_card => :get }
  

  #  resources :jobposts do
  #   collection do
  #     get :edit_jobpostdetail
  #     put :update_jobpostdetail
  #   end
  # end

  resources :jobposts do
  get 'edit_jobpostdetail', :on => :member
  put 'update_jobpostdetail', :on => :member
end
  #get "static_pages/home"
  # get "static_pages/whyrubynow"
  # get "static_pages/rubyguides"
  # get "static_pages/expertadvice"
  # get "static_pages/privacypolicy"
  # get "static_pages/termsofuse"
  #get "static_pages/contactus"
  #match '/', to: 'static_pages#home'
  root  :to =>'static_pages#home'

  match '/contactus', to: 'static_pages#contactus'
  match '/termsofuse', to: 'static_pages#termsofuse'
  match '/privacypolicy', to: 'static_pages#privacypolicy'
  match '/expertadvice', to: 'static_pages#expertadvice'
  match '/rubyguides', to: 'static_pages#rubyguides'
  match '/whyrubynow', to: 'static_pages#whyrubynow'
  match '/find-a-rails-developer', to: 'static_pages#findarailsdeveloper'

  # match '/signup',  to: 'users#new'
  # match '/signin',  to: 'sessions#new'
  # match '/signout', to: 'sessions#destroy', via: :delete

   match '/signup' => 'users#new'
  match '/signin' => 'sessions#new'
  match '/signout' => 'sessions#destroy'
  #match '/signout', to: 'sessions#destroy', via: :delete

   match '/dashboard' => 'users#dashboard'
   match '/edit' => 'users#edit'
   match '/editjobpostdetail' => 'jobposts#edit_jobpostdetail'
   match '/previewjobpost' => 'jobposts#show'
   #match '/jobpostsedit' => 'jobposts#edit'

   match '/current_cart' => 'carts#show'

   match '/sellect_payment' => 'payments#sellect_payment'
   # get "payments/credit_card"
   match '/credit_card' => 'payments#credit_card'
   match '/credit_card_confirm' => 'payments#credit_card_confirm'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
