Rails.application.routes.draw do
  
  mount GrapeSwaggerRails::Engine => '/apidocs'

  post 'auth', to: 'authentication#authenticate'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace 'api' do
      namespace 'v1' do
          resources :scenarios do
            resources :rrhs
          end

          resources :pops
          resources :users
          resources :scripts
          resources :alarms

          resources :network_services do
              resources :vnfs
              get 'vnfs/:id/activate', to: "vnfs#activate"
          end
      end
  end
end
