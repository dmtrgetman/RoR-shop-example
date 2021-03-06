Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # No-WWW redirection
  # Use webserver (nginx or Apache) redirection too, because static files requests evade this rule
  constraints host: /^www\./i do
    get ':any', to: redirect {|p, req| "#{req.protocol}#{req.host_with_port[4..-1]}/#{p[:any]}" }, any: /.*/
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # feedback
  get 'feedback' => 'feedback#new', as: :feedback
  post 'feedback' => 'feedback#create'

  # news
  resources :news, only: [:index, :show]

  # pages
  get '/cart', to: 'cart#index'
  post '/cart', to: 'cart#cartls'
  post '/makeorder', to: 'order#make'

  get '*page_path' => 'pages#show', as: :page

  # You can have the root of your site routed with "root"
  root 'home#index'


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
