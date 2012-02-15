Rails.application.routes.draw do
  resources :orders do
      resource :checkout, :controller => 'checkout' do
        member do
          get :create_stac
          get :stac_response
          # get :paypal_checkout
          # get :paypal_payment
          # get :paypal_confirm
          # post :paypal_finish
        end
      end
    end
end
