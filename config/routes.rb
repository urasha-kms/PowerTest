PowerTest::Application.routes.draw do
  resources :topic
  # get "main/index"
  root :to => 'main#index'
#  get 'main/about'  => 'main#about'
#  get 'main/download'  => 'main#download'
#  get 'main/index'  => 'main#setup'
#  get 'testing/show'  => 'testing#show'
#  post 'main/index'  => 'main#setup'
  post 'admin/index' => 'admin#edit_user'
#  post 'admin/index' => 'admin#index'
  resources :testing do
    collection do
      get 'show', 'change_topic', 'change_category', 'change_numticket', 'change_quest', 'change_answer', 'accept_answer'
    end
  end

  resources :main do
    collection do
      get 'show', 'about', 'group', 'download', 'setup'
    end
  end

  resources :admin do
    collection do
      get 'index', 'select_user', 'create_user', 'edit_user', 'destroy_user' 
    end
  end

resources :sessions, :only => [:new, :create, :destroy]

  get '/signup',  :to => 'users#new'
  get '/signin',  :to => 'sessions#new'
  get '/signout', :to => 'sessions#destroy'

  namespace :admin do
    resources :user
  end

 # match 'topic/index' => 'topic#show'
 # match 'topic/new'   => 'topic#new'
 # match 'topic/:id'   => 'topic#edit'
 # get 'topic/:id' => 'topic#edit'
 # post 'topic/create'
 # put "topic/:id" => "topic#update"

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
  # root :to => 'main#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
