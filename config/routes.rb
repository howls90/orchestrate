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
          resources :scripts

          resources :network_services do
              resources :vnfs
          end
          resources :alarms
      end
      
      namespace 'testing' do
          resources :scenarios do
            resources :rrhs
          end

          resources :pops
          resources :scripts

          resources :network_services do
              resources :vnfs
          end
          resources :alarms
      end
  end
end
