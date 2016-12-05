Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'plivo/forward', to: 'plivo#forward', as: :plivo_forward
  post 'plivo/dial', to: 'plivo#dial', as: :plivo_dial
  post 'plivo/record', to: 'plivo#record', as: :plivo_record
end
