Rails.application.routes.draw do

  ###############
  # error pages #
  ###############

  get '/403', to: 'errors#forbidden_403'
  get '/404', to: 'errors#not_found_404'
  get '/500', to: 'errors#internal_server_error_500'
  get '/503', to: 'errors#service_unavailable_503'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  resources :resolutions

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
