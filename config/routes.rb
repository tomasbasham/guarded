Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: 'v1', as: :v1, constraints: ApiConstraint.new(version: 1, default: true) do
    resources :posts
    resources :users
  end
end
