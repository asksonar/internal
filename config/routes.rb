Rails.application.routes.draw do

  ###############
  # error pages #
  ###############

  match '/403', to: 'errors#forbidden_403', via: :all
  match '/404', to: 'errors#not_found_404', via: :all
  match '/500', to: 'errors#internal_server_error_500', via: :all
  match '/503', to: 'errors#service_unavailable_503', via: :all

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  resources :resolutions

  ################
  # shared login #
  ################

  devise_for :user,
    path_names: {
      sign_up: 'admin_sign_up',
      sign_in: 'login',
      sign_out: 'logout'
    }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
