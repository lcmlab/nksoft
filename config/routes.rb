Nksoft::Application.routes.draw do
#  get "top/index"
  root to: "top#index"

  resources :employees do
    collection { get "search" }
  end

  resources :workreports do

    collection do
      get 'emplye_wreport'
      get 'search'
      get 'subord_workreport'
      get 'set_subordsprange'
      get 'set_bulksubordinp1'
      get 'set_bulksubordinpconfirm'
      put 'subord_bulkcreate'
    end
    #member { get "set_subordsprange" }
    #collection { get "set_subordsprange" }

  end

  resource :session, only: [:create, :destroy]



  namespace :admin do
     root to: "top#index"
     resources :employees do
       collection { get "search" }
     end

     resources :workreports do

       collection do
         get 'emplye_wreport'
         get 'wreport_sammary'
         get 'search'
         get 'emp_workreport'
       end
       member { get "set_empdsprange" }
       #member { get "emp_workreport" }

     end

     resources :departments
     resources :states
     resources :clients
     resources :projects
     resources :jobgroups
     resources :jobitems
     resources :jobplaces
     resources :addcomments
     resources :grades
     resources :splittimes

  end


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
